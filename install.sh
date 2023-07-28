#!/bin/bash
set -e

stow -V || (echo "Please install GNU Stow"; exit 1)

TARGETS=(
    flake8
    fonts
    gdb
    git
    htop
    mc
    mpv
    ranger
    tmux
    vim
    zsh
)

case $(uname) in
Linux)
    TARGETS+=(
        awesome
        firejail
        picom
        rofi
        xorg
        zathura

        alacritty
        sway
    )
;;
Darwin)
    TARGETS+=(
        alacritty
        hammerspoon
    )
;;
esac

pushd ${HOME}/.dotfiles
for X in ${TARGETS[@]}; do
    echo "Installing ${X}..."
    if [[ "$X" == "htop" ]]; then
        mkdir -p ~/.config/htop/
        cp htop/.config/htop/htoprc ~/.config/htop/htoprc
        continue
    fi;

    if [[ "$X" == "awesome" ]]; then
        touch ~/.awesome.local.lua
    fi;

    if [[ "$X" == "xorg" ]]; then
        touch ~/.Xresources.local
    fi;

    stow -D $X
    stow $X
done;
popd
