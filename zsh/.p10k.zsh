# Generated by Powerlevel10k configuration wizard on 2021-12-16 at 10:55 MSK.
# Based on romkatv/powerlevel10k/config/p10k-classic.zsh.

# Tip: Looking for a nice color? Here's a one-liner to print colormap.
#   for i in {0..255}; do print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}; done

# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh -o extended_glob
  unset -m '(POWERLEVEL9K_*|DEFAULT_USER)~POWERLEVEL9K_GITSTATUS_DIR'
  autoload -Uz is-at-least && is-at-least 5.1 || return

  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      context                 # user@hostname
      ssh
      dir                     # current directory
      root_indicator
      midnight_commander      # midnight commander shell (https://midnight-commander.org/)
      kubecontext             # current kubernetes context (https://kubernetes.io/)
  )

  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      vcs                     # git status
      status                  # exit code of the last command
      virtualenv              # python virtual environment (https://docs.python.org/3/library/venv.html)
      command_execution_time  # duration of the last command
  )

  typeset -g POWERLEVEL9K_MODE=nerdfont-complete
  typeset -g POWERLEVEL9K_ICON_PADDING=none
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=false

  typeset -g POWERLEVEL9K_LEFT_SUBSEGMENT_SEPARATOR='%244F\uE0B1'          # same-color segments on the left
  typeset -g POWERLEVEL9K_RIGHT_SUBSEGMENT_SEPARATOR='%244F\uE0B3'         # same-color segments on the right
  typeset -g POWERLEVEL9K_LEFT_SEGMENT_SEPARATOR='\uE0B0'                  # different-color segments on the left
  typeset -g POWERLEVEL9K_RIGHT_SEGMENT_SEPARATOR='\uE0B2'                 # different-color segments on the right
  typeset -g POWERLEVEL9K_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL='\uE0B0'     # right end of left prompt
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_FIRST_SEGMENT_START_SYMBOL='\uE0B2' # left end of right prompt
  typeset -g POWERLEVEL9K_LEFT_PROMPT_FIRST_SEGMENT_START_SYMBOL=''        # left end of left prompt
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_LAST_SEGMENT_END_SYMBOL=''          # right end of right prompt
  typeset -g POWERLEVEL9K_EMPTY_LINE_LEFT_PROMPT_LAST_SEGMENT_END_SYMBOL=  # left prompt terminator for lines without any segments

  ##################################[ dir: current directory ]##################################
  typeset -g POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='237'
  typeset -g POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='blue'
  typeset -g POWERLEVEL9K_DIR_HOME_BACKGROUND='237'
  typeset -g POWERLEVEL9K_DIR_HOME_FOREGROUND='blue'
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='237'
  typeset -g POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='blue'
  typeset -g POWERLEVEL9K_SHORTEN_STRATEGY=truncate_from_right
  typeset -g POWERLEVEL9K_SHORTEN_DELIMITER=…
  # typeset -g POWERLEVEL9K_DIR_SHORTENED_FOREGROUND=24
  typeset -g POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
  typeset -g POWERLEVEL9K_DIR_SHOW_WRITABLE=v3 # special styling for non-writable and non-existent directories
  typeset -g POWERLEVEL9K_LOCK_ICON='⭐'
  typeset -g POWERLEVEL9K_DIR_CLASSES=('*' DEFAULT '')

  #####################################[ vcs: git status ]######################################
  typeset -g POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
  typeset -g POWERLEVEL9K_VCS_CLEAN_BACKGROUND='237'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='249'
  typeset -g POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='237'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='yellow'
  typeset -g POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='237'

  ##########################[ status: exit code of the last command ]###########################
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=false
  typeset -g POWERLEVEL9K_STATUS_OK=false
  typeset -g POWERLEVEL9K_STATUS_ERROR_BACKGROUND='088'
  typeset -g POWERLEVEL9K_STATUS_ERROR_FOREGROUND='blue'

  ###################[ command_execution_time: duration of the last command ]###################
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=3
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=2
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_VISUAL_IDENTIFIER_EXPANSION=

  ##################################[ context: user@hostname ]##################################
  typeset -g POWERLEVEL9K_CONTEXT_BACKGROUND='black'
  typeset -g POWERLEVEL9K_CONTEXT_FOREGROUND=250
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_FOREGROUND=1
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_BACKGROUND=88
  typeset -g POWERLEVEL9K_CONTEXT_{REMOTE,REMOTE_SUDO}_FOREGROUND=180
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%B%n@%m'
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%n@%m'
  # typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_{CONTENT,VISUAL_IDENTIFIER}_EXPANSION= # don't show context unless running with privileges or in SSH

  ###[ virtualenv: python virtual environment (https://docs.python.org/3/library/venv.html) ]###
  typeset -g POWERLEVEL9K_VIRTUALENV_FOREGROUND=37
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_PYTHON_VERSION=true
  typeset -g POWERLEVEL9K_VIRTUALENV_SHOW_WITH_PYENV=false
  typeset -g POWERLEVEL9K_VIRTUALENV_{LEFT,RIGHT}_DELIMITER=

  #############[ kubecontext: current kubernetes context (https://kubernetes.io/) ]#############
  typeset -g POWERLEVEL9K_KUBECONTEXT_SHOW_ON_COMMAND='kubectl|helm'
  typeset -g POWERLEVEL9K_KUBECONTEXT_CLASSES=('*' DEFAULT)
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_FOREGROUND=38
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_BACKGROUND=237
  typeset -g POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION=
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${P9K_KUBECONTEXT_CLOUD_CLUSTER:-${P9K_KUBECONTEXT_NAME}}'
  POWERLEVEL9K_KUBECONTEXT_DEFAULT_CONTENT_EXPANSION+='${${:-/$P9K_KUBECONTEXT_NAMESPACE}:#/default}'

  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=off
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=verbose
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  (( ! $+functions[p10k] )) || p10k reload
}

# Tell `p10k configure` which file it should overwrite.
typeset -g POWERLEVEL9K_CONFIG_FILE=${${(%):-%x}:a}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
