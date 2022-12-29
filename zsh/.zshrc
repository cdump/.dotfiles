# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export GOPATH=$HOME/devel/go
export PATH=$HOME/.local/bin/:$HOME/.poetry/bin:/opt/gotools/bin:$GOPATH/bin:$PATH
export CUDACXX=/usr/local/cuda/bin/nvcc

export LANG=en_US.UTF-8
export EDITOR=nvim
export PAGER=less
export BROWSER=chromium

# poetry completions zsh
# fpath=(~/.zsh-completions/src $fpath)
autoload -U compaudit compinit
compinit

source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme

source ~/.zsh_plugins/ohmyzsh/lib/spectrum.zsh # colors, spectrum_ls
source ~/.zsh_plugins/ohmyzsh/plugins/encode64/encode64.plugin.zsh
source ~/.zsh_plugins/ohmyzsh/plugins/tmux/tmux.plugin.zsh
source ~/.zsh_plugins/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh
source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# expand sudo aliases
alias sudo='sudo '

if [[ $(uname ) == "Darwin" ]]; then
    alias ls='ls -F --color=auto'
else
    alias ls='ls -F --color=auto --group-directories-first'
fi

alias qr='qrencode -t ansiutf8'

alias vim='nvim'

alias ll='ls -l'
alias la='ls -la'
alias grep='grep --color'
alias gclean='git clean -Xdi'

alias gdb='gdb --quiet'
alias gd='gdb --quiet -ex r --args'
alias dsf='diff-so-fancy | less --tabs=4 -RFX'

alias kgc='kubectl config get-contexts'
alias kuc='kubectl config use-context'
alias kun='kubectl config set-context --current --namespace'
alias kgn='kubectl get namespaces'
alias klf='kubectl logs --tail=100 -f'

bindkey -e
bindkey "${terminfo[kdch1]}" delete-char
bindkey "${terminfo[khome]}" beginning-of-line
bindkey "${terminfo[kend]}" end-of-line

#LISTMAX=200
setopt notify               # report the status of background jobs immediately, rather than waiting until just before printing a prompt
setopt interactive_comments # allow comments even in interactive shells
export WORDCHARS=''         # ex: Ctrl+W also jumps to '/', and other 'behavior more like bash'
setopt auto_cd              # if a command is issued that can't be executed as a normal command, and the command is the name of a directory, perform the cd command to that directory
setopt auto_pushd           # make cd push the old directory onto the directory stack
setopt long_list_jobs       # print job notifications in the long format by default (with PID)
# setopt print_exit_value   # print the exit value of programs with non-zero exit status

HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=10000
setopt hist_ignore_all_dups # if a new command line being added to the history list duplicates an older one, the older command is removed from the list (even if it is not the previous event)
setopt hist_ignore_space    # remove command lines from the history list when the first character on the line is a space, or when one of the expanded aliases contains a leading space
setopt hist_reduce_blanks   # remove superfluous blanks from each command line being added to the history list
setopt inc_append_history_time
setopt extended_history     # save each command's beginning timestamp (in seconds since the epoch) and the duration (in seconds) to the history file
unsetopt share_history
alias rh='fc -RI'           # refresh-history

# setopt menu_complete        # on an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately
setopt complete_in_word
setopt always_to_end
setopt globdots             # include .dotfiles in completion

zstyle ':completion:*' menu select # search
zstyle ':completion:*' completer _complete _match #_approximate
zstyle ':completion:*:match:*' original only
# zstyle ':completion:*:approximate:*' max-errors 'reply=($((($#PREFIX+$#SUFFIX)/3))numeric)'
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # match uppercase from lowercase

# Mc
export MC_SKIN=xoria256_patched

# Color MAN
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

export BAT_THEME="Monokai Extended"

ds() {
	objdump -M intel -d $* | less
}

sum() {
    perl -lane '$s+=$_;$c++;END{print "Sum $s\tCnt: $c\tAvg: ".$s/$c;}'
}

vag() {
    local line
    line=`ag --nocolor "$1" | fzf --select-1 --exit-0 --delimiter ':' --query "$1" \
        --preview='bat --style "plain,numbers" --paging=never --pager=cat --color=always --line-range $( x=$(( $(echo {2}) - $FZF_PREVIEW_LINES/2 )); [[ $x -lt 0 ]] && echo 0 || echo $x):$(( $(echo {2}) + $FZF_PREVIEW_LINES/2 - 1 )) --highlight-line {2} {1} '` \
        && vim -R $(cut -d':' -f1 <<< "$line") +$(cut -d':' -f2 <<< "$line")
}

copy_terminfo() {
    infocmp | ssh $1 tic -x -
}

source_if_exists() {
    [ -f $1 ] && source $1
}

alias hex_escaped='od -An -tx1 | sed -E "s/([0-9a-f]{2})/\\\x\1/g"|tr -d " \n"'
alias hex_0x='od -An -tx1 | sed -E "s/([0-9a-f]{2})/0x\1,/g"|tr -d " \n"'

# arch-linux
source_if_exists /usr/share/fzf/completion.zsh
source_if_exists /usr/share/fzf/key-bindings.zsh

# ubuntu
source_if_exists /usr/share/doc/fzf/examples/key-bindings.zsh
source_if_exists /usr/share/doc/fzf/examples/completion.zsh

source_if_exists ~/.p10k.zsh
source_if_exists ~/.local.zsh
