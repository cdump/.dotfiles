#!/bin/bash
set -e

stow -V || (echo "Please install GNU Stow"; exit 1)

TARGETS=(
    fonts
    gdb
    git
    htop
    mc
    mpv
    ranger
    yazi
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
        foot
        ssh-agent
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

    if [[ "$X" == "ssh-agent" ]]; then
        # systemd needs a real directory, not a symlink
        mkdir -p ~/.config/systemd/user/ssh-agent.service.d/
        mkdir -p ~/.local/bin/
    fi;

    stow -D $X
    stow $X

    if [[ "$X" == "fonts" ]]; then
        ~/.local/share/fonts/nerd-fonts/install.sh
    fi;
done;
popd
