POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh dir root_indicator midnight_commander)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status virtualenv command_execution_time)
POWERLEVEL9K_SHORTEN_STRATEGY="truncate_from_right"
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_STATUS_OK=false

POWERLEVEL9K_CONTEXT_DEFAULT_BACKGROUND='black'
POWERLEVEL9K_CONTEXT_DEFAULT_FOREGROUND='250'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='238'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='250'
POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='237'
POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='blue'
POWERLEVEL9K_DIR_HOME_BACKGROUND='237'
POWERLEVEL9K_DIR_HOME_FOREGROUND='blue'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='237'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='blue'
POWERLEVEL9K_STATUS_ERROR_BACKGROUND='088'
POWERLEVEL9K_STATUS_ERROR_FOREGROUND='blue'
POWERLEVEL9K_STATUS_OK_BACKGROUND='black'
POWERLEVEL9K_STATUS_OK_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
POWERLEVEL9K_VCS_CLEAN_BACKGROUND='237'
POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='249'
POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='237'
POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='237'

export GOPATH=$HOME/devel/go
export PATH=$HOME/.local/bin/:$HOME/.poetry/bin:/opt/gotools/bin:$GOPATH/bin:$PATH
export CUDACXX=/usr/local/cuda/bin/nvcc

# poetry completions zsh
# fpath=(~/.zsh-completions/src $fpath)
autoload -U compaudit compinit
compinit

source ~/.zsh_plugins/powerlevel10k/powerlevel10k.zsh-theme

source ~/.zsh_plugins/ohmyzsh/plugins/encode64/encode64.plugin.zsh
source ~/.zsh_plugins/ohmyzsh/plugins/tmux/tmux.plugin.zsh
source ~/.zsh_plugins/ohmyzsh/plugins/command-not-found/command-not-found.plugin.zsh

alias ls='ls -F --color=auto --group-directories-first'
alias grep='grep --color'
alias gclean='git clean -Xdi'

alias gdb='gdb --quiet'
alias gd='gdb --quiet -ex r --args'
alias dsf='diff-so-fancy | less --tabs=4 -RFX'

export EDITOR=vim
export LANG=en_US.UTF-8
# export BROWSER=chromium

bindkey -e
LISTMAX=200
setopt NOTIFY        # Report status of background jobs immediately.
setopt interactive_comments # comments starting with '#'
export WORDCHARS='' # ex: Ctrl+W also jumps to '/', and other 'behavior more like bash'

export HISTSIZE=10000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_reduce_blanks
setopt inc_append_history_time
setopt extended_history # save timestamp of command and duration
unsetopt share_history
alias refresh-history='fc -RI'

setopt MENU_COMPLETE # On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately
setopt complete_in_word
setopt always_to_end
zstyle ':completion:*' menu select # search

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

vk() {
    chromium-browser "https://vk.com/id1?z=photo$1"
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

source ~/.zsh_plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh_plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
