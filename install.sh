#!/bin/bash

SRC=${HOME}/.dotfiles
DST=${HOME}

link() {
    to=${2:-$1}
    mkdir -p ${DST}/$(dirname ${to})
    ln -s -T ${SRC}/$1 ${DST}/${to}
}

link .xinitrc
link .Xresources
link .Xresources.d
touch ${DST}/.Xresources.local

link .vim
link .vimrc

link .zshrc
link .zsh_plugins

link .tmux.conf

link .gdbinit

link .gitconfig

link .flake8

link .urxvt/ext/font-size

link .themes/absolute
link .icon/elementary
link .fonts/nerd-fonts
link .local/share/mc/skins/xoria256_patched.ini

link .config/zathura
link .config/ranger
link .config/picom
link .config/mpv
link .config/awesome
touch ~/.awesome.local.lua


link .diff-so-fancy/diff-so-fancy .local/bin/diff-so-fancy

mkdir -p ${DST}/.config/htop/
cp ${SRC}/.config/htop/htoprc ${DST}/.config/htop/htoprc
