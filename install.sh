#!/bin/bash

stow -V || (echo "Please install GNU Stow"; exit 1)

pushd ${HOME}/.dotfiles
for X in          \
    awesome       \
    diff-so-fancy \
    flake8        \
    gdb           \
    git           \
    mc            \
    mpv           \
    picom         \
    ranger        \
    rofi          \
    tmux          \
    urxvt         \
    vim           \
    xorg          \
    zathura       \
    zsh           \
; do
    stow -D $X
    stow $X
done;

mkdir -p ~/.config/htop/
cp htop/.config/htop/htoprc ~/.config/htop/htoprc

touch ~/.Xresources.local
touch ~/.awesome.local.lua

popd
