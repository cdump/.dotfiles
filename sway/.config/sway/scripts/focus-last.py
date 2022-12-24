#!/home/user/.config/sway/scripts/.venv/bin/python -u

import asyncio
import os
import tempfile
from argparse import ArgumentParser
from collections import defaultdict

import i3ipc.aio


SOCKET_FILE = f'{tempfile.gettempdir()}/i3_focus_{os.geteuid()}_{os.getenv("DISPLAY")}-{os.getenv("WAYLAND_DISPLAY")}.sock'
MAX_WIN_HISTORY = 15

class FocusWatcher:
    def __init__(self):
        self.window_map = defaultdict(list)
        if os.path.exists(SOCKET_FILE):
            os.remove(SOCKET_FILE)

    async def run(self):
        self.i3 = await i3ipc.aio.Connection(auto_reconnect=True).connect()
        self.i3.on('window::focus', self.on_window_focus)
        self.i3.on('workspace::focus', self.on_workspace_focus)
        self.current_workspace_num = next(x.num for x in await self.i3.get_workspaces() if x.focused)
        await asyncio.start_unix_server(self.client_cb, path=SOCKET_FILE)
        await self.i3.main()

    def on_window_focus(self, i3conn, event):
        window_id = event.container.id
        window_list = self.window_map[self.current_workspace_num]
        if window_id in window_list:
            window_list.remove(window_id)
        window_list.insert(0, window_id)
        if len(window_list) > MAX_WIN_HISTORY:
            del window_list[MAX_WIN_HISTORY:]

    def on_workspace_focus(self, i3conn, event):
        self.current_workspace_num = event.current.num

    async def client_cb(self, reader, write):
        tree = await self.i3.get_tree()
        windows = set()
        for c in tree:
            if not c.nodes \
                and not c.floating_nodes \
                and c.type in {"con", "floating_con"} \
                and c.parent.type != "dockarea" \
                and c.workspace().num == self.current_workspace_num:
                    windows.add(c.id)

        window_list = self.window_map[self.current_workspace_num]
        if len(window_list) < 2:
            await self.i3.command('focus next')
            return

        for window_id in window_list[1:]:
            if window_id not in windows:
                window_list.remove(window_id)
            else:
                await self.i3.command('[con_id=%s] focus' % window_id)
                return


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--switch', action='store_true', help='Switch to the previous window', default=False)
    args = parser.parse_args()
    loop = asyncio.new_event_loop()
    if not args.switch:
        loop.run_until_complete(FocusWatcher().run())
    else:
        loop.run_until_complete(asyncio.open_unix_connection(path=SOCKET_FILE))
