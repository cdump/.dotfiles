#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# dependencies = [
#     "i3ipc",
# ]
# ///

from argparse import ArgumentParser
import subprocess
import socket
import os
import json

import i3ipc

def wprefix(num: int, full: bool = True) -> str:
    assert 0 < num and num < 100, f'{num} not in range[1;99]'
    digits = [('0', '₀'), ('1', '₁'), ('2', '₂'), ('3', '₃'), ('4', '₄'), ('5', '₅'), ('6', '₆'), ('7', '₇'), ('8', '₈'), ('9', '₉')]
    if num < 10:
        a, b = digits[num]
        return f'{a}:{b}' if full else b

    a, b = digits[num // 10]
    c, d = digits[num % 10]
    return f'{a}{c}:{b}{d}' if full else f'{b}{d}'

def move_workspace(conn, wm, move: int):
    current_num = None
    names = [None]*11
    for w in conn.get_workspaces():
        names[w.num] = w.name
        if w.focused:
            current_num = w.num
    assert current_num is not None
    current_name = names[current_num].split(' ', 1)[1]

    new_num = current_num + move
    if new_num < 1 or new_num > 10:
        return

    if new_num >= len(names) or names[new_num] is None:
        cmds = [f'rename workspace "{names[current_num]}" to "{wprefix(new_num)} {current_name}"']
    else:  # swap
        new_name = names[new_num].split(' ', 1)[1]
        cmds = [
            f'rename workspace "{names[current_num]}" to "tmprename"',
            f'rename workspace "{names[new_num]}" to "{wprefix(current_num)} {new_name}"',
            f'rename workspace "tmprename" to "{wprefix(new_num)} {current_name}"',
        ]

    conn.command(';'.join(cmds))

def window_to_new_workspace(conn, wm):
    if wm == 'i3':
        workspaces = set(w.num for w in conn.get_workspaces())
    else:
        workspaces = set(w['id'] for w in conn.exec('workspaces'))

    first_empty_num = min(set(range(6,100)) - workspaces)  # start only from 6

    if wm == 'i3':
        focused_name = conn.get_tree().find_focused().name
        name = f'{wprefix(first_empty_num)} {focused_name}'
        conn.command(f'move container to workspace "{name}"; workspace "{name}"')
    else:
        focused_name = conn.exec('activewindow')['title']
        idx = wprefix(first_empty_num, False)
        conn.exec(f'dispatch movetoworkspace {first_empty_num}', wait_ok=True)
        conn.exec(f'dispatch renameworkspace {first_empty_num} {idx} {focused_name}', wait_ok=True)


def rename_workspace(conn, wm):
    r = subprocess.run(['rofi', '-dmenu', '-theme', 'bottom', '-p', 'new name'], input='', capture_output=True)
    new_name = r.stdout.decode('utf-8').rstrip()
    if new_name == '':
        return

    if wm == 'i3':
        workspaces = conn.get_workspaces()
        focused_name = [w.name for w in workspaces if w.focused][0]
        idx, _ = focused_name.split(' ', 1)
        conn.command(f'rename workspace "{focused_name}" to "{idx} {new_name}"')
    else:
        wid = conn.exec('activeworkspace')['id']
        idx = wprefix(wid, False)
        conn.exec(f'dispatch renameworkspace {wid} {idx} {new_name}', wait_ok=True)



class HyprClient:
    def exec(self, cmd: str, wait_ok: bool = False):
        self.sock = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
        self.sock.connect(f"{os.getenv('XDG_RUNTIME_DIR')}/hypr/{os.getenv('HYPRLAND_INSTANCE_SIGNATURE')}/.socket.sock")
        self.sock.send(f'[j]/{cmd}'.encode())
        buf = b''
        while True:
            d = self.sock.recv(4096)
            if not d:
                break
            buf += d
        print(cmd, buf)
        if buf == b'unknown request':
            raise Exception(f'Unknown request: {cmd}')
        if wait_ok:
            if buf == b'ok' or buf == b"Not moving to workspace because it didn't change.":
                return
        return json.loads(buf.decode())


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--wm',                      choices=['i3', 'hypr'], default='i3')
    parser.add_argument('--move-workspace',          choices=['left', 'right'])
    parser.add_argument('--rename-workspace',        action='store_true')
    parser.add_argument('--window-to-new-workspace', action='store_true' )
    args = parser.parse_args()

    conn = i3ipc.Connection(auto_reconnect=True) if args.wm == 'i3' else HyprClient()

    if args.window_to_new_workspace:
        window_to_new_workspace(conn, args.wm)

    elif args.rename_workspace:
        rename_workspace(conn, args.wm)

    elif args.move_workspace is not None:
        move_workspace(conn, args.wm, -1 if args.move_workspace == 'left' else 1)

    else:
        parser.print_help()
