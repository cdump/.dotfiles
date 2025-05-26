#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "aiohttp",
# ]
# ///

import os
import sys
import argparse
import asyncio
import datetime
import json
import tempfile
import xml.etree.ElementTree as ET

from dataclasses import dataclass
from collections import defaultdict
from typing import List, Tuple, Optional

import aiohttp

@dataclass
class Info:
    open_price: float
    low_price: float
    high_price: float
    last_price: float
    change_percent: float

async def fetch_xml(url):
    async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=1)) as session:
        async with session.get(url) as response:
            raw = await response.text()
            return ET.fromstring(raw)

async def fetch_json(url):
    async with aiohttp.ClientSession(timeout=aiohttp.ClientTimeout(total=1)) as session:
        async with session.get(url) as response:
            return await response.json()


class Moex:
    def __init__(self, engine, market, board):
        self.url_prefix = f'http://iss.moex.com/iss/engines/{engine}/markets/{market}/boards/{board}/securities.json'
        self.url_prefix += '?iss.meta=off&iss.only=securities,marketdata&marketdata.columns=OPEN,LOW,HIGH,LAST&securities.columns=PREVPRICE&securities='

    async def fetch(self, tickers: List[str]) -> List[Tuple[str, Optional[Info]]]:
        r = await fetch_json(f'{self.url_prefix}{",".join(tickers)}')
        resp = []
        for ticker, (prev_price,), data in zip(tickers, r['securities']['data'], r['marketdata']['data']):
            if prev_price is not None:
                change_pcnt = (data[-1] - prev_price) * 100 / prev_price
                resp.append((ticker, Info(*[*data, change_pcnt])))
            else:
                resp.append((ticker, None))
        return resp


class Cbr:
    async def fetch(self, tickers: List[str]):
        tree = await fetch_xml('https://cbr.ru/scripts/XML_daily.asp')
        values = {rec.findtext('CharCode'): float(rec.findtext('Value').replace(',', '.')) for rec in tree.findall('Valute')}
        return [(ticker, Info(*[values[ticker]] * 4, 0)) for ticker in tickers]


class Binance:
    async def fetch(self, tickers: List[str]):
        raw = await fetch_json(f'https://api.binance.com/api/v3/ticker/tradingDay?timeZone=3&symbols={json.dumps(tickers).replace(" ", "")}')
        fields = ('openPrice', 'lowPrice', 'highPrice', 'lastPrice', 'priceChangePercent')
        resp = [(r['symbol'], Info(*[float(r[x]) for x in fields])) for r in raw]
        return resp


PROVIDERS = {
    'moex_currency': Moex('currency', 'selt', 'CETS'),
    'moex_futures': Moex('futures', 'forts', 'RFUD'),
    'binance': Binance(),
    'cbr': Cbr(),
}


def format_line(symbol: str, res: Optional[Info], short: bool):
    if res is None:
        return f'{symbol} ?'
    if res.change_percent >= 0:
        color = '33aa33'
        prefix = '+'
    else:
        color = 'ee4444'
        prefix = ''
    if short:
        return f'{symbol}<span color="#{color}">{res.last_price:.1f}</span>'
    else:
        return f'{symbol} {res.last_price:.2f} <span font="sans 6" color="#{color}">{prefix}{res.change_percent:.1f}%</span>'


async def process(tickers):
    by_type = defaultdict(list)
    sorted_results = []
    ticker2pos = {}
    for pos, (xtype, ticker, symbol) in enumerate(tickers):
        by_type[xtype].append((ticker, symbol))
        sorted_results.append([ticker, symbol, None])
        ticker2pos[ticker] = pos

    while True:
        for el in await asyncio.gather(*[PROVIDERS[xtype].fetch([v[0] for v in tlist]) for xtype, tlist in by_type.items()], return_exceptions=True):
            if isinstance(el, Exception):
                # print(f'exception: {el}')
                continue
            for ticker, data in el:
                sorted_results[ticker2pos[ticker]][-1] = data

        line = '<span color="#666666"> | </span>'.join(format_line(symbol, res, False) for _, symbol, res in sorted_results)
        short_line = '<span color="#666666">|</span>'.join(format_line(symbol, res, True) for _, symbol, res in sorted_results)

        tooltip = f'<span color="#555555">update {datetime.datetime.now()}</span>\n'
        tooltip += f'{".":<10s}' + ''.join(f'{symbol:<10s}' for _, symbol, _ in sorted_results)
        for title, field in (('open', 'open_price'), ('low', 'low_price'), ('high', 'high_price'), ('last', 'last_price'), ('change%', 'change_percent')):
            tooltip += f'\n{title:<10s}'
            for _, _, res in sorted_results:
                if res:
                    tooltip += f'<span color="#{"33aa33" if res.change_percent > 0 else "ee4444"}">{getattr(res, field):<10.2f}</span>'
                else:
                    tooltip += f'{"?":<10s}'

        yield line, short_line, tooltip


class ControlServer:
    def __init__(self):
        self.socket_file = f'{tempfile.gettempdir()}/stonks_{os.geteuid()}.sock'
        self._msg = []
        self._event = asyncio.Event()

    async def socket_cb(self, reader, _):
        msg = await reader.read(1)
        self._msg.append(msg)
        self._event.set()

    async def _get_event(self):
        await self._event.wait()
        msg = self._msg.pop()
        if msg == b'\x00':
            sys.exit(0)

        if len(self._msg) == 0:
            self._event.clear()
        return msg

    async def exec(self, cmd: bytes):
        _, writer = await asyncio.open_unix_connection(path=self.socket_file)
        writer.write(cmd)
        await writer.drain()

    async def get_event(self, timeout):
        try:
            return await asyncio.wait_for(self._get_event(), timeout)
        except asyncio.TimeoutError:
            return None

    async def start(self):
        if os.path.exists(self.socket_file):
            try:
                await self.exec(b'\x00')
            except:
                pass
            os.remove(self.socket_file)
        await asyncio.start_unix_server(self.socket_cb, path=self.socket_file)


async def main(cmd, tickers, update_timeout):
    csrv = ControlServer()
    if cmd is not None:
        return await csrv.exec(cmd)
    await csrv.start()

    short_mode = False
    short_mode = True
    async for line, short_line, tooltip in process(tickers):
        print(json.dumps({'text': short_line if short_mode else line, 'tooltip': tooltip, 'alt': 'shiftdel'}), flush=True)

        ev = await csrv.get_event(update_timeout)
        if ev is not None:
            if ev == b't':
                short_mode = not short_mode
            # print('event', ev)
        # await asyncio.sleep(update_timeout)


def parse_arg_ticker(s: str):
    x = s.split(':')
    assert len(x) == 3
    assert x[0] in PROVIDERS
    return x


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('--cmd', choices=['update-now', 'toggle-mode'],  help='send command to running app')
    args, _ = parser.parse_known_args()

    req = args.cmd is None
    parser.add_argument('--ticker', type=parse_arg_ticker, action='append', help='tickers, format: {provider}:{ticker}:{symbol}', required=req)
    parser.add_argument('--update-interval', type=int, default=60, help='update interval, seconds', required=False)
    args = parser.parse_args()

    cmd = args.cmd[0].encode('ascii') if args.cmd is not None else None
    asyncio.run(main(cmd, args.ticker, args.update_interval))
