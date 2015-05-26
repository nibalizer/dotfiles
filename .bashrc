# Spencer Krum a.k.a nibalizer's environment
# Specifically staying within bash here

# Check for an interactive session
[ -z "$PS1" ] && return

# Use Vim
export EDITOR=`which vim`

# What, you don't have your own mail spool?
MAIL=/var/spool/mail/nibz && export MAIL

# Sometimes we need to know where the awesome is
if [ -d $HOME/local/bin ]; then
  SCRIPTS=$HOME/local/bin && export SCRIPTS
fi

# Dat unicode
if [ -e /usr/share/terminfo/r/rxvt-256color ]; then
  export TERM='rxvt-256color'
else
  export TERM='rxvt-color'
fi


# Set Lang
if [ `uname -s` = "SunOS" ] ; then
  export LANG="C"
else
  export LANG="en_US.UTF-8"
fi

# Do I have a very custom ~local I've put things in?

if [ -d $HOME/local ]; then
  export PATH=${HOME}/local/bin:${HOME}/local/sbin:${PATH}
  export MANPATH=${HOME}/local/share/man:${MANPATH}
fi


# The Dynamic Languages: Perl, Python, Ruby

# RUBY
# Manage ruby through rvm
# Install rvm with
# \curl -sSL https://get.rvm.io | bash -s -- --ignore-dotfiles

if [ -d $HOME/.rvm/bin ]; then
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

# PERL
# Manage perl with perlbrew
# Install perlbrew with
# \curl -L http://install.perlbrew.pl | bash

if [ -d $HOME/perl5/etc/bashrc ]; then
  source ~/perl5/perlbrew/etc/bashrc
fi

# PYTHON
# Manage python with virtualenv
# Install virtualenv from packages

# Source a global 2.7 virtualenv for convenience
# Create this with virtualenv ~/.globalpip

if [ -d $HOME/.globalpip ]; then
  VIRTUAL_ENV_DISABLE_PROMPT=yes source $HOME/.globalpip/bin/activate 
fi

# Experimental support for globally available virtualenvs
# Basically implement rvm on top of virtualenv

#TODO switch this out for virtualenvwrapper

if [ -d $HOME/.virtualenvs ]; then
  VENV_ROOT=$HOME/.virtualenvs
  venv-list () {
    ls -l $VENV_ROOT | awk '{ print $9 " " $6 " " $7 " "$8 } ' | column -t
  }
fi

# NODE
# It kills me to need to put this here
# There doesn't seem to be a rvm/virtualenv/perlbrew for node
# Correction there is nvm now
# So we install it from binary tarball into ~/local and hope for the best

# Everything done often should be short and fast

alias ta='tmux attach'
alias sdr='screen -dr'
alias ls='ls -F --color=auto'
alias v='vagrant'
alias l='ls -F'
alias la='ls -Fa'
alias ll='ls -Fl'
alias x='exit'

# I'm a bad typist

alias sl=ls
alias mdkir=mkdir


# Git aliases

alias gs='git status'
alias gl='git log'
alias go='git checkout'
alias gob='git checkout -b'
alias gb='git branch'
alias ga='git add'
alias gd='git diff'
alias gc='git commit'
alias gca='git commit --amend'
alias gcm='git commit -m'
alias gg='git grep'
alias gr='git remote'
alias gp='git pull'
alias gpom='git push origin master'


# Going beyond aliases

wodim () {
  /usr/bin/wodim -v $1
  eject -T
}

[ -f /usr/bin/vim ] && alias vi='vim'


#feel good aliases 
#there are really old
#kept here becuase the past is awesome
alias xkcd='konqueror &'
alias kb='. /home/nibz/Documents/Scripts/kb.sh'
#alias win='. /home/nibz/Documents/Scripts/win.sh'
alias win=$SCRIPTS/win.sh
alias wifi='. /home/nibz/Documents/Scripts/newwireless_script.sh'
alias bashrc='vim /home/nibz/.bashrc && source /home/nibz/.bashrc'
alias xorg='. /home/nibz/Documents/Scripts/xorg.sh'
alias pgc='ping google.com'
alias goodnight='. $SCRIPTS/sleep.sh'
alias rtfm='man'


PS1='[\u@\h \W]\$ '


# There may be local confiugration to soruce
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

# Stuff from maxwell, uncatagorized

alias gs='git show --pretty=oneline'
alias gpom='git push origin master'
alias gogozer='git reset --hard origin/hp/gozer; git pull'
#alias cdp='cd $HOME/work/devel/config' # obsoleted by cdp function
alias ppv='puppet parser validate'
export GOPATH=$HOME/go

export PATH=$PATH:$GOPATH/bin

alias doit='TERM=xterm ssh -t destiny ssh -t nightshade screen -dr main'
alias utcdate='TZ=utc date'
#alias whatsupdoc='source ~/corepip/bin/activate ; curl -s 'http://graphite.openstack.org/render/?width=586&height=308&_salt=1413871126.453&target=sum%28stats_counts.gerrit.event.*)&format=json' | json_pp | grep ',' | grep -v \] | grep -v target | tr -d "," | diagram'



if [ -f '/disk/blob/nibz/sandbox/google-cloud-sdk/path.bash.inc' ]; then
  # The next line updates PATH for the Google Cloud SDK.
  source '/disk/blob/nibz/sandbox/google-cloud-sdk/path.bash.inc'
  # The next line enables bash completion for gcloud.
  source '/disk/blob/nibz/sandbox/google-cloud-sdk/completion.bash.inc'
fi


if [ -f  $HOME/.myshell.sh ]; then
    source ~/.myshell.sh
fi

if [ -f $HOME/corepip/bin/activate ]; then
    VIRTUAL_ENV_DISABLE_PROMPT="Yes Please" source $HOME/corepip/bin/activate
    unset $VIRTUAL_ENV_DISABLE_PROMPT
fi
export ZSCREEN_SCREENSHOT_DIR=$HOME/Pictures/screenshots

cdp () {

  TEMP_PWD=`pwd`
  while ! [ -d .git ]; do
  cd ..
  done
  OLDPWD=$TEMP_PWD

}


alias x='xclip -o | xclip -selection clipboard'

# Define and run ssh-agent managment command
goagent () {

    agent_num=$1
    if [ -z $agent_num ]; then
        agent_num=1
    fi
    . ~/.ssh/agent_${agent_num}
    if ! ps -ef | grep ssh-agent | grep $SSH_AGENT_PID >/dev/null ; then
        ssh-agent |head -n 2 > ~/.ssh/agent_${agent_num}
        . ~/.ssh/agent_${agent_num}
    fi
}
goagent

sshadd () {
    ssh-add -c -t 3600
}

alias domain-list="designate --os-endpoint  https://region-a.geo-1.dns.hpcloudsvc.com/v1/ record-list 9609dad3-fc98-451f-9bfc-0978be5733c5"


gerrit () {

    if [ $1 = "wip" ]; then
        commit=`git show | grep -m1 commit | cut -d " " -f 2 2>/dev/null`
        if [ -z $commit ]; then
            echo "Not in git directory?"
            return 1
        fi
        gerrit review $commit --workflow -1
        return $?
    fi

    username=`git config gitreview.username`

    ssh -o VisualHostKey=no -p 29418 $username@review.openstack.org gerrit $*
}


function pr() {
  id=$1
  git fetch origin pull/${id}/head:pr_${id}
  git checkout pr_${id}
}

function catspeak() {
  curl --data-binary "$*" -H 'Content-Type: text/plain'  https://intranet.cecs.pdx.edu/api/notify/notify.cgi
}


# added by travis gem
[ -f /home/nibz/.travis/travis.sh ] && source /home/nibz/.travis/travis.sh

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
#HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
#shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
#HISTSIZE=1000
#HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize
# amixer -D pulse sset Master 5%+
function cleanfloat() {
    for ip in `nova floating-ip-list | awk '/ - / {print $4}'`
        do echo $ip
        nova floating-ip-delete $ip
    done
}


### Idea
# git grep thing
# vim +/thing file
# override vim based on if git grep was last thing said

alias fucking=sudo
#for mopidy
export XDG_MUSIC_DIR=${HOME}/Music
export XDG_MUSIC_DIR=${HOME}/Music
alias gh='cat ~/work/gh'

ghn () {
  if [ -z $1 ];then
    echo "Need host"
    return
  fi
  gozerhost=$1
  gh | grep $gozerhost | cut -d "," -f 2

}

alias feh='feh -F'
alias setupenv='setxkbmap us -variant colemak -option ctrl:nocaps -option altwin:swap_lalt_lwin'

alias g='git'
alias gr='git review'


export SC2READER_CACHE_DIR=${HOME}/.sc2cache
export SC2READER_CACHE_MAX_SIZE=200


# Source work things

if [ -f ${HOME}/work/.bash_things ]; then
    source ${HOME}/work/.bash_things
fi

#bashopt defaults
export BASHOPT_RVM_ENABLE=off

if [ -f  $HOME/.bashopt ]; then
    source ~/.bashopt
fi
