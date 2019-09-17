POWERLEVEL9K_INSTALLATION_PATH=~/.zplug/repos/bhilburn/powerlevel9k/
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(context ssh dir root_indicator)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vcs status command_execution_time)
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

source ~/.zplug/init.zsh

zplug "plugins/git",   from:oh-my-zsh
zplug "plugins/encode64",   from:oh-my-zsh
zplug "plugins/tmux",   from:oh-my-zsh
zplug "plugins/command-not-found",   from:oh-my-zsh
zplug "plugins/common-aliases",   from:oh-my-zsh

zplug "zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:2

zplug "romkatv/powerlevel10k", as:theme

if ! zplug check --verbose; then
    zplug install
fi

zplug load

unalias rm
unalias cp
unalias mv
unalias gb
alias ls='ls -F --color=auto --group-directories-first'

alias gdb='gdb --quiet'
alias gd='gdb --quiet -ex r --args'

export EDITOR=vim
export LANG=en_US.UTF-8
# export BROWSER=chromium

bindkey -e
LISTMAX=200
setopt MENU_COMPLETE # On an ambiguous completion, instead of listing possibilities or beeping, insert the first match immediately
setopt NOTIFY        # Report status of background jobs immediately.
export HISTSIZE=10000
setopt HIST_IGNORE_ALL_DUPS
unsetopt share_history
HISTFILE=~/.zsh_history
SAVEHIST=5000
zstyle ':completion:*' menu yes select search

# Mc
export MC_SKIN=xoria256_patched

# ls
export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=01;37;41:sg=30;43:ca=30;41:tw=30;42:ow=30;42:st=30;44:ex=01;32:*.7z=00;31:*.Z=00;31:*.ace=00;31:*.arj=00;31:*.bz=00;31:*.bz2=00;31:*.cpio=00;31:*.deb=00;31:*.dz=00;31:*.ear=00;31:*.gz=00;31:*.jar=00;31:*.lz=00;31:*.lzh=00;31:*.lzma=00;31:*.rar=00;31:*.rpm=00;31:*.rz=00;31:*.sar=00;31:*.tar=00;31:*.taz=00;31:*.tbz=00;31:*.tbz2=00;31:*.tgz=00;31:*.tlz=00;31:*.txz=00;31:*.tz=00;31:*.war=00;31:*.xz=00;31:*.z=00;31:*.zip=00;31:*.zoo=00;31:*.anx=00;33:*.axv=00;33:*.bmp=00;33:*.cgm=00;33:*.dl=00;33:*.emf=00;33:*.flc=00;33:*.fli=00;33:*.gif=00;33:*.gl=00;33:*.jpeg=00;33:*.jpg=00;33:*.mng=00;33:*.nuv=00;33:*.pbm=00;33:*.pcx=00;33:*.pgm=00;33:*.png=00;33:*.ppm=00;33:*.svg=00;33:*.svgz=00;33:*.tga=00;33:*.tif=00;33:*.tiff=00;33:*.xbm=00;33:*.xcf=00;33:*.xpm=00;33:*.xwd=00;33:*.yuv=00;33:*.asf=00;35:*.avi=00;35:*.flv=00;35:*.m2v=00;35:*.m4v=00;35:*.mkv=00;35:*.mov=00;35:*.mp4=00;35:*.mp4v=00;35:*.mpeg=00;35:*.mpg=00;35:*.ogm=00;35:*.ogv=00;35:*.ogx=00;35:*.qt=00;35:*.rm=00;35:*.rmvb=00;35:*.vob=00;35:*.webm=00;35:*.wmv=00;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:';

# Color MAN
export LESS_TERMCAP_mb=$'\E[01;31m'
export LESS_TERMCAP_md=$'\E[01;38;5;74m'
export LESS_TERMCAP_me=$'\E[0m'
export LESS_TERMCAP_se=$'\E[0m'
export LESS_TERMCAP_so=$'\E[38;33;246m'
export LESS_TERMCAP_ue=$'\E[0m'
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

ds() {
	objdump -M intel -d $* | less
}

vk() {
    chromium-browser "https://vk.com/id1?z=photo$1"
}

sum() {
    perl -lane '$s+=$_;$c++;END{print "Sum $s\tCnt: $c\tAvg: ".$s/$c;}'
}

export GOPATH=$HOME/devel/go
export PATH=/home/user/.local/bin/:/opt/gotools/bin:/usr/lib/go-1.12/bin:$GOPATH/bin:$PATH
export CUDACXX=/usr/local/cuda/bin/nvcc

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
