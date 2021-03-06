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

# auto change directory
shopt -s autocd

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=100000
HISTFILESIZE=200000

# set vi mode in bash shell
# set -o vi

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

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    #PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# Some ls aliases
alias ls='exa --group-directories-first'
alias ll='ls -alF'
alias la='ls -a'

alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

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

# Source the bashrc file in the OpenFOAM installation etc directory to the
# .bashrc file in the HOME directory
source /opt/openfoam7/etc/bashrc

# Set default editor
export EDITOR=/usr/bin/vim

# Point DISPLAY variable to the X server that is running
# export DISPLAY=:0
export DISPLAY="`grep nameserver /etc/resolv.conf | sed 's/nameserver //'`:0"

# Set the windows username
export WIN_USER=$(find /mnt/c/Users -maxdepth 3 -type f -name winUserLocate | sed 's@/mnt/c/Users/\(.*\)/Documents/.*@\1@g')

#My list of environment variables.
export DOCUMENTS=/mnt/c/Users/$WIN_USER/Documents
export DOWNLOADS=/mnt/c/Users/$WIN_USER/Downloads
export DESKTOP=/mnt/c/Users/$WIN_USER/Desktop
export GMSH=/mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/gmsh-3.0.5-Windows
export CURRENT=/mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2019_2020_1/slantedPlateReport
export FIGURES=/mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2019_2020_1/slantedPlateReport/figures
export POWERLINE=/home/adzlan/.local/lib/python3.6/site-packages/powerline
export REPLYOE=/mnt/c/Users/alan_/OneDriveUNIMAS/PhDWork/2020_2021_1/OceanEngineering/replyToReviewers

# Here I add my own command aliases
alias cl='clear'
alias ev='vim $HOME/.vim/vimrc'
alias eb='vim $HOME/.vim/bashrc'
alias sb='source $HOME/.vim/bashrc'
alias mc='mc -P "/tmp/mc-$USER/mc.pwd.$$"; cd `cat /tmp/mc-$USER/mc.pwd.$$`; rm /tmp/mc-$USER/*'
alias rb='find . -type f -name "*~" | xargs rm'
alias ct='rm *.aux *.bbl *.log *.xml *.blg *~ *.bcf *.abs *.fls *.out *.gz *fdb_latexmk *.dvi'

# Navigation shortcuts
alias ..='cd ..'
alias 2.='cd ../..'
alias 3.='cd ../../..'
alias 4.='cd ../../../..'
alias 5.='cd ../../../../..'
alias 6.='cd ../../../../../..'
alias 7.='cd ../../../../../../..'
alias 8.='cd ../../../../../../../..'
alias 9.='cd ../../../../../../../../..'
alias 10.='cd ../../../../../../../../../..'

# A list of aliases to important folders in the Windows directory.
alias gmsh='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/gmsh-3.0.5-Windows'
alias phda='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2017_2018_1'
alias phdb='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2017_2018_2'
alias phdc='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2018_2019_1'
alias phdd='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2018_2019_2'
alias phde='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2019_2020_1'
alias phdf='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2020_2021_1'
alias doc='cd /mnt/c/Users/$WIN_USER/Documents'
alias des='cd /mnt/c/Users/$WIN_USER/Desktop'
alias dow='cd /mnt/c/Users/$WIN_USER/Downloads'
alias of1706='cd $(find /mnt/c/OpenFOAM/17.06/ -maxdepth 2 -type d -name run)'
alias cur='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2019_2020_1/slantedPlateReport'
alias whom='cd /mnt/c/Users/$WIN_USER'
alias fig='cd /mnt/c/Users/$WIN_USER/OneDriveUNIMAS/PhDWork/2019_2020_1/slantedPlateReport/figures'
alias app='cd ~/Documents/appliedEnergy2020'
alias rep='cd /mnt/c/Users/alan_/OneDriveUNIMAS/PhDWork/2020_2021_1/OceanEngineering/replyToReviewers'

# Git aliases
alias gst='git status'
alias ga='git add'
alias gcam='git commit -a -m'
alias gcmsg='git commit -m'

# My little tweaking of the BASH prompt
export PROMPT_DIRTRIM=1

# Powerline-status
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /home/adzlan/.local/lib/python3.6/site-packages/powerline/bindings/bash/powerline.sh

# Neofetch
# neofetch

# Broot
source /home/adzlan/.config/broot/launcher/bash/br

# Use fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Use z.lua
eval "$(lua /home/adzlan/.config/z.lua/z.lua --init bash)"
export _ZL_ECHO=1
alias zi='z -i'
