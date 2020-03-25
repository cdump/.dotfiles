#!/bin/bash

ln -s -T ~/.dotfiles/.Xresources ~/.Xresources
touch ~/.Xresources.local

ln -s -T ~/.dotfiles/.xinitrc ~/.xinitrc

ln -s -T ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s -T ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s -T ~/.dotfiles/.vim ~/.vim
ln -s -T ~/.dotfiles/.vimrc ~/.vimrc
ln -s -T ~/.dotfiles/.zshrc ~/.zshrc
ln -s -T ~/.dotfiles/.zsh_plugins ~/.zsh_plugins

mkdir -p ~/.local/bin
ln -s ~/.dotfiles/.diff-so-fancy/diff-so-fancy ~/.local/bin

mkdir -p ~/.urxvt/ext
ln -s -T ~/.dotfiles/.urxvt/ext/font-size ~/.urxvt/ext/font-size

mkdir ~/.themes
ln -s -T ~/.dotfiles/.themes/absolute ~/.themes/absolute

mkdir ~/.icons
ln -s -T ~/.dotfiles/.icons/elementary ~/.icons/elementary

mkdir ~/.fonts
ln -s -T ~/.dotfiles/.fonts/nerd-fonts ~/.fonts/nerd-fonts

mkdir -p ~/.local/share/mc/skins
ln -s -T ~/.dotfiles/.local/share/mc/skins/xoria256_patched.ini ~/.local/share/mc/skins/xoria256_patched.ini

mkdir ~/.config
ln -s -T ~/.dotfiles/.config/awesome ~/.config/awesome
touch ~/.awesome.local.lua

mkdir ~/.config/zathura
ln -s -T ~/.dotfiles/.config/zathura/zathurarc ~/.config/zathura/zathurarc

mkdir ~/.config/htop
cp ~/.dotfiles/.config/htop/htoprc ~/.config/htop/htoprc
