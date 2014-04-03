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

if [ -d $HOME/.virtualenvs ]; then
  VENV_ROOT=$HOME/.virtualenvs
  venv-list () {
    ls -l $VENV_ROOT | awk '{ print $9 " " $6 " " $7 " "$8 } ' | column -t
  }
fi

# NODE
# It kills me to need to put this here
# There doesn't seem to be a rvm/virtualenv/perlbrew for node
# So we install it from binary tarball into ~/local and hope for the best

# Everything done often should be short and fast

alias ta='tmux attach'
alias sdr='screen -dr'
alias ls='ls -F'
alias v='vagrant'
alias l='ls -F'
alias la='ls -Fa'
alias ll='ls -Fl'
alias x='exit'


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

alias ls='ls --color=auto'

PS1='[\u@\h \W]\$ '


# There may be local confiugration to soruce
[ -f ~/.bashrc.local ] && source ~/.bashrc.local

