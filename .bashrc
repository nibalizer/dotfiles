#if [ -e /usr/share/terminfo/x/xterm-256color ]; then
#        export TERM='xterm-256color'
#else
#        export TERM='xterm-color'
#fi
export EDITOR=/usr/bin/vim

if [ -e /usr/share/terminfo/r/rxvt-256color ]; then
        export TERM='rxvt-256color'
else
        export TERM='rxvt-color'
fi

#sets the Mail environmet variable
MAIL=/var/spool/mail/nibz && export MAIL

SCRIPTS=/home/nibz/Documents/Scripts

# Check for an interactive session
[ -z "$PS1" ] && return


#feel good aliases to scripts
alias xkcd='konqueror &'
alias kb='. /home/nibz/Documents/Scripts/kb.sh'
alias win='. /home/nibz/Documents/Scripts/win.sh'
alias wifi='. /home/nibz/Documents/Scripts/newwireless_script.sh'
alias bashrc='vim /home/nibz/.bashrc && source /home/nibz/.bashrc'
alias xorg='. /home/nibz/Documents/Scripts/xorg.sh'
alias pgc='ping google.com'
alias goodnight='. $SCRIPTS/sleep.sh'
alias rtfm='man'

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '
