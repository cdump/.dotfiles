#!/bin/sh
"exec" "`dirname $0`/.venv/bin/python" "-u" "$0" "$@"

from argparse import ArgumentParser
import subprocess

import i3ipc

PREFIXES = [None, '1:₁', '2:₂', '3:₃', '4:₄', '5:₅', '6:₆', '7:₇', '8:₈', '9:₉', '10:₁₀']

def move_workspace(i3, move: int):
    current_num = None
    names = [None]*11
    for w in i3.get_workspaces():
        names[w.num] = w.name
        if w.focused:
            current_num = w.num
    assert current_num is not None
    current_name = names[current_num].split(' ', 1)[1]

    new_num = current_num + move
    if new_num < 1 or new_num > 10:
        return

    if new_num >= len(names) or names[new_num] is None:
        cmds = [f'rename workspace "{names[current_num]}" to "{PREFIXES[new_num]} {current_name}"']
    else:  # swap
        new_name = names[new_num].split(' ', 1)[1]
        cmds = [
            f'rename workspace "{names[current_num]}" to "tmprename"',
            f'rename workspace "{names[new_num]}" to "{PREFIXES[current_num]} {new_name}"',
            f'rename workspace "tmprename" to "{PREFIXES[new_num]} {current_name}"',
        ]

    i3.command(';'.join(cmds))

def window_to_new_workspace(i3):
    workspaces = set(w.num for w in i3.get_workspaces())
    first_empty_num = min(set(range(6,10)) - workspaces)  # start only from 6

    focused_name = i3.get_tree().find_focused().name
    name = f'{PREFIXES[first_empty_num]} {focused_name}'
    i3.command(f'move container to workspace "{name}"; workspace "{name}"')


def rename_workspace(i3):
    r = subprocess.run(['bemenu', '--bottom', '--no-overlap', '--prompt', 'new name'], input='', capture_output=True)
    new_name = r.stdout.decode('utf-8').rstrip()
    if new_name == '':
        return

    workspaces = i3.get_workspaces()
    focused_name = [w.name for w in workspaces if w.focused][0]
    idx, _ = focused_name.split(' ', 1)
    i3.command(f'rename workspace "{focused_name}" to "{idx} {new_name}"')


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--move-workspace',          choices=['left', 'right'])
    parser.add_argument('--rename-workspace',        action='store_true')
    parser.add_argument('--window-to-new-workspace', action='store_true' )
    args = parser.parse_args()

    conn = i3ipc.Connection(auto_reconnect=True)
    if args.window_to_new_workspace:
        window_to_new_workspace(conn)

    elif args.rename_workspace:
        rename_workspace(conn)

    elif args.move_workspace is not None:
        move_workspace(conn, -1 if args.move_workspace == 'left' else 1)

    else:
        parser.print_help()
