# Profiling [START]
#PS4='+ $(date "+%s.%N")\011 '
#exec 3>&2 2>/tmp/bashstart.$$.log
#set -x

# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# ETERNAL history
# Undocumented feature which sets the size to "unlimited".
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
# # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
# HISTSIZE=10000
# HISTFILESIZE=20000
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi
export color_prompt

# Load git prompt support once
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
fi

# Prompt configuration

# Colors
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
GOLD='\[\033[33m\]'
RESET='\[\033[00m\]'

# Load git prompt support once
if [ -f ~/.git-prompt.sh ]; then
    source ~/.git-prompt.sh
    GIT_PS1_SHOWDIRTYSTATE=1
fi

# Track current prompt state
PROMPT_STATE=${PROMPT_STATE:-"minimal"}

# Function to actually build PS1 dynamically
build_prompt() {
    case "$PROMPT_STATE" in
        long)
            if [ "$color_prompt" = yes ]; then
                if type __git_ps1 &>/dev/null; then
                    PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u${RESET}:${BLUE}\w${GOLD}$(__git_ps1 ' (%s)')${RESET}\$ "
                else
                    PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u:${BLUE}\w${RESET}\$ "
                fi
            else
                PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w\$ "
            fi
            ;;
        minimal)
            if [ "$color_prompt" = yes ]; then
                PS1="${debian_chroot:+($debian_chroot)}${GREEN}\u:${BLUE}\W${RESET}\$ "
            else
                PS1="${debian_chroot:+($debian_chroot)}\u:\W\$ "
            fi
            ;;
    esac
}

# PROMPT_COMMAND is executed before each prompt → recomputes PS1
PROMPT_COMMAND=build_prompt

# Toggle function
toggle_prompt() {
    local force_state="$1"
    if [ "$force_state" = "long" ] || ([ -z "$force_state" ] && [ "$PROMPT_STATE" = "minimal" ]); then
        PROMPT_STATE="long"
    else
        PROMPT_STATE="minimal"
    fi
}

# unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alFrt'
alias la='ls -A'
alias l='ls --format=single-column -Art'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# setting go tools available for $PATH
export PATH=$PATH:/usr/local/go/bin

# make $PATH and $HOME available for sudo
alias psudo='sudo env PATH=$PATH HOME=$HOME'

# setting $GOPATH and making available for $PATH
export GOPATH=$HOME/go/
export PATH=$PATH:$GOPATH/bin

alias dgit='/usr/bin/git --git-dir=$HOME/.dgit --work-tree=$HOME'

alias s='source $HOME/.bashrc'

export PATH="$PATH:/opt/mssql-tools/bin"
export PATH="$PATH:/opt/mssql-tools/bin"
export PATH="$PATH:~/azuredatastudio-linux-x64"

export XDG_CONFIG_HOME=$HOME/.config

export VERSION_ID="20.04"

alias lr='ls -R'


export KBD_BACKLIGHT="/sys/devices/plat^Crm/dell-laptop/leds/dell\:\:kbd_backlight/stop_timeout"

removecontainers() {
    docker stop $(docker ps -aq)
    docker rm $(docker ps -aq)
}

armageddon() {
    removecontainers
    docker network prune -f
    docker rmi -f $(docker images --filter dangling=true -qa)
    docker volume rm $(docker volume ls --filter dangling=true -q)
    docker rmi -f $(docker images -qa)
}

# Check $HOME/.scripts for custom commands and bash snippet

alias git-stats='$HOME/git-quick-stats/git-quick-stats'

export DENO_INSTALL="/home/fbaltor/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

alias yacc="bison"

# Profiling [END]
#set +x
#exec 2>&3 3>&-

alias chrome='google-chrome --allow-file-access-from-files'

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

fif() {
  grep --line-buffered --color=never -r --exclude-dir=node_modules "" * | fzf
}

#  Setting neovim
# NVIM_PATH='/opt/nvim-linux64/bin/nvim'
# alias nvim=$NVIM_PATH

# Setting editors
export GIT_EDITOR=vi

# Setup flutter path
export PATH=$PATH:$HOME/flutter/bin

. "$HOME/.cargo/env"

# Setup pyenv path
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Setup bun path
export BUN_INSTALL="/home/fbaltor/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

export PATH="$HOME/.local/bin:$PATH"
if [ -n "$PYTHONPATH" ]; then
    export PYTHONPATH='/home/fbaltor/.local/share/pdm/venv/lib/python3.10/site-packages/pdm/pep582':$PYTHONPATH
else
    export PYTHONPATH='/home/fbaltor/.local/share/pdm/venv/lib/python3.10/site-packages/pdm/pep582'
fi

# Added by serverless binary installer
export PATH="$HOME/.serverless/bin:$PATH"

# Extended regex
shopt -s extglob

# BATTERY COMMANDS
# Show battery status
alias bat='upower -i /org/freedesktop/UPower/devices/battery_BAT0'
# TODO: this doesn't work...
# Trigger battery charge keeping the custom mode limits
# alias charge='sudo smbios-battery-ctl --set-charging-mode=standard && sudo smbios-battery-ctl --set-charging-mode=custom'
# TODO: check if the command below works
# Trigger express battery charge keeping the custom mode limits
# alias charge-quickly='smbios-battery-ctl --set-charging-mode=express && smbios-battery-ctl --set-charging-mode=custom'

# Chromium latest
alias gcl='$HOME/chromium-latest-linux/run.sh'

# depot_tools
export PATH="$PATH:$HOME/depot_tools"

# Disabling Google API keys on Chromium
export GOOGLE_API_KEY="no"
export GOOGLE_DEFAULT_CLIENT_ID="no"
export GOOGLE_DEFAULT_CLIENT_SECRET="no"

# Addind chromedriver to PATH
export PATH="$PATH:/opt/chromedriver/chromedriver"

# pnpm
export PNPM_HOME="/home/fbaltor/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# flutter
export PATH="$PATH:/home/fbaltor/flutter/bin"
# flutter end

# fnm
export PATH="/home/fbaltor/.local/share/fnm:$PATH"
eval "`fnm env`"

# Bun debug
export PATH="$PATH:/home/fbaltor/bun/packages/debug-bun-linux-x64"

# Deno debug
alias deno-debug="$HOME/deno/target/debug/deno"

# fnm
export PATH="/home/fbaltor/.local/share/fnm:$PATH"
eval "`fnm env`"

# THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

alias ltspice="wine $HOME/.wine/drive_c/Program\ Files/LTC/LTSpiceXVII/XVIIx64.exe"

# >>> juliaup initialize >>>

# !! Contents within this block are managed by juliaup !!

case ":$PATH:" in
    *:/home/fbaltor/.juliaup/bin:*)
        ;;

    *)
        export PATH=/home/fbaltor/.juliaup/bin${PATH:+:${PATH}}
        ;;
esac

# <<< juliaup initialize <<<

alias watchcore="watch -n 2 sensors -A coretemp-isa-0000"

# fnm
FNM_PATH="/home/fbaltor/.local/share/fnm"
if [ -d "$FNM_PATH" ]; then
  export PATH="$FNM_PATH:$PATH"
  eval "`fnm env`"
fi

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/fbaltor/miniforge3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/fbaltor/miniforge3/etc/profile.d/conda.sh" ]; then
        . "/home/fbaltor/miniforge3/etc/profile.d/conda.sh"
    else
        export PATH="/home/fbaltor/miniforge3/bin:$PATH"
    fi
fi
unset __conda_setup

if [ -f "/home/fbaltor/miniforge3/etc/profile.d/mamba.sh" ]; then
    . "/home/fbaltor/miniforge3/etc/profile.d/mamba.sh"
fi
# <<< conda initialize <<<


complete -C /usr/bin/terraform terraform
complete -C /usr/local/bin/aws_completer aws
