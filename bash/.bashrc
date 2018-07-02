# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

shopt -s expand_aliases
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

set -o noclobber

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
shopt -s globstar

export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:/home/moopet/.gem/ruby/2.5.0/bin"
export BLOCKSIZE=human-readable
#export TERM=screen-256color
export LC_ALL=en_GB.UTF-8
export VISUAL=vim
export EDITOR=vim
export BROWSER=google-chrome-stable

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
fi

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/bin/git-completion ] && . ~/bin/git-completion

function _update_ps1() {
  PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
  PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

if [ "$(uname)" = "Darwin" ]; then
  if [ -f ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh ]; then
    . ~/.vim/plugged/gruvbox/gruvbox_256palette_osx.sh
  fi
elif [ "$TERM" = "screen-256color" -o "$TERM" = "xterm-256color" ]; then
  if [ -f ~/.vim/plugged/gruvbox/gruvbox_256palette.sh ]; then
    . ~/.vim/plugged/gruvbox/gruvbox_256palette.sh
  fi
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

