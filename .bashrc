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

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

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
#force_color_prompt=yes

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

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

    #alias grep='grep --color=auto'
    #alias fgrep='fgrep --color=auto'
    #alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
#alias ll='ls -l'
#alias la='ls -A'
#alias l='ls -CF'

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

# ==== Above this line Debian Default

# = Path Munging
# Yes I am aware Debian seems to prefer .local
export PATH=${HOME}/local/bin:${PATH}


# = IBM
# Use the beta ux for the IBM Cloud Kubernetes cli tool
export IKS_BETA_VERSION=1.0
# .bash_completion is automatically sourced by debian's default files
# ibmcloud_cli autocompletion is installed to ~/.bash_completion.d by (my) installer
# I am not a 'real' user so disable ibmcloud cli analytics
export IBMCLOUD_ANALYTICS=false
alias iks='ibmcloud ks'
alias ikcc='ibmcloud ks cluster config'

# = The land of aliases
alias alphabet='echo a b c d e f g h i j k l m n o p q r s t u v w x y z'
alias bsc='git add .; git commit -a -m "Bull Shit Commit"; git push origin master'
alias demogods='toilet --gay --font mono9 woo demo'
alias egrep='egrep --color=auto'
alias feh='feh -F'
alias fgrep='fgrep --color=auto'
alias fucking='sudo'
alias gitbranchfix='git fetch origin; git branch --set-upstream-to=origin/master master'
alias grep='grep --color=auto'
alias jsoncheck='jq "." < '
alias lady='man' # from mlane
alias ll='ls -l'
alias ls='ls -F --color=auto'
alias ppv='puppet parser validate'
alias pseudo='[ $((RANDOM % 2)) -eq 0 ] && sudo' # from jason owen
alias rfc2616='cat ${HOME}/local/share/rfc2616_reference.txt'
alias rv='remote-viewer spice://localhost:5900'
alias sdr='screen -dr'
alias selectors="cat ${HOME}/local/share/css_reference.txt"
alias ssh300='ssh-add -t 300'
alias t='terraform'
alias ta='tmux attach'
alias urlencode='python -c "import sys, urllib as ul; print ul.quote_plus(sys.argv[1])"'
alias utcdate='TZ=utc date'
alias v='vagrant'
alias x='exit'
alias yamlcheck='python -c "import sys, yaml as y; y.safe_load(open(sys.argv[1]))"'
# I'm a bad typist
alias sl=ls
alias mdkir=mkdir
# Git aliases
alias g='git'
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gd='git diff'
alias gg='git grep'
alias gl='git log'
alias go='git checkout'
alias gob='git checkout -b'
alias gp='git pull'
alias gpom='git push origin master'
alias gr='git remote'
alias grom='git reset --hard origin/master'
alias gs='git status'


# = Useful Functions

# Show the weather
weather () {
    curl -4 http://wttr.in/${1}
    :
}

# Find files by name
fname () {
    item=$1
    find . -name "*${item}*"
}

# Go to the root of the git repository
cdp () {

  TEMP_PWD=`pwd`
  while ! [ -d .git ]; do
  cd ..
  done
  OLDPWD=$TEMP_PWD

}

# Check out a github pull-request
function pr() {
  id=$1
  git fetch origin pull/${id}/head:pr_${id}
  git checkout pr_${id}
}

# = Misc

# colored GCC warnings and errors
export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# Always vim
[ -f /usr/bin/vim ] && alias vi='vim'
export EDITOR=vim

# Source work things

if [ -f ${HOME}/work/.bash_things ]; then
    source ${HOME}/work/.bash_things
fi

# Feel good aliases 
# These are really old and are kept here becuase its fun to remember the past
alias xkcd='konqueror &'
alias kb='. /home/nibz/Documents/Scripts/kb.sh'
alias win=$SCRIPTS/win.sh
alias wifi='. /home/nibz/Documents/Scripts/newwireless_script.sh'
alias bashrc='vim /home/nibz/.bashrc && source /home/nibz/.bashrc'
alias xorg='. /home/nibz/Documents/Scripts/xorg.sh'
alias pgc='ping google.com'
alias goodnight='. $SCRIPTS/sleep.sh'
alias rtfm='man'

