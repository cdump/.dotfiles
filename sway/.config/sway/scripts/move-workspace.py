#!/bin/sh
"exec" "`dirname $0`/.venv/bin/python" "-u" "$0" "$@"

from argparse import ArgumentParser

import i3ipc

def prepare_swap_cmd(a, b):
    a_idx, a_name = a.split(' ', 1)
    b_idx, b_name = b.split(' ', 1)

    if a_name != b_name:
        return [
            f'rename workspace "{b}" to "{a_idx} {b_name}"',
            f'rename workspace "{a}" to "{b_idx} {a_name}"',
        ]
    else:
        return [
            f'rename workspace "{a}" to "tmp_{a}"',
            f'rename workspace "{b}" to "{a_idx} {b_name}"',
            f'rename workspace "tmp_{a}" to "{b_idx} {a_name}"',
        ]

def process(move: int):
    i3 = i3ipc.Connection(auto_reconnect=True)
    tree = i3.get_workspaces()

    names = []
    focused = None
    for i, c in enumerate(tree):
        names.append(c.name)
        if c.focused:
            focused = i

    assert focused is not None

    if (0 <= focused + move) and (focused + move <= len(names) - 1):
        for cmd in prepare_swap_cmd(names[focused], names[focused+move]):
            i3.command(cmd)


if __name__ == '__main__':
    parser = ArgumentParser()
    parser.add_argument('--move', required=True, choices=['left', 'right'])
    args = parser.parse_args()
    process(-1 if args.move == 'left' else 1)
