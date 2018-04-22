#!/bin/bash

ln -s -T ~/.dotfiles/.Xresources ~/.Xresources
touch ~/.Xresources.local

ln -s -T ~/.dotfiles/.xinitrc ~/.xinitrc

ln -s -T ~/.dotfiles/.gitconfig ~/.gitconfig
ln -s -T ~/.dotfiles/.tmux.conf ~/.tmux.conf
ln -s -T ~/.dotfiles/.vim ~/.vim
ln -s -T ~/.dotfiles/.vimrc ~/.vimrc
ln -s -T ~/.dotfiles/.zshrc ~/.zshrc
ln -s -T ~/.dotfiles/.zsh_antigen ~/.zsh_antigen

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

mkdir ~/.config/htop
cp ~/.dotfiles/.config/htop/htoprc ~/.config/htop/htoprc
