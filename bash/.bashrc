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
if [ "${BASH_VERSINFO:-0}" -ge 4 ]; then
  shopt -s globstar
fi

export PATH="$HOME/.local/bin:$HOME/bin:$HOME/.composer/vendor/bin:$PATH"
export PATH="$PATH:$HOME/.gem/ruby/2.5.0/bin"
export BLOCKSIZE=human-readable
export LC_ALL=en_GB.UTF-8
export VISUAL=vim
export EDITOR=vim
export BROWSER=google-chrome-stable

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

[ -f ~/.aliases ] && . ~/.aliases
[ -f ~/bin/git-completion ] && . ~/bin/git-completion
[ -f ~/shore-projects/shore_aliases.sh ] && . ~/shore-projects/shore_aliases.sh

if [ -d "$HOME/Library/Python/2.7/bin" ]; then
  export PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

function _update_ps1() {
  if command -v powerline-shell > /dev/null; then
    PS1=$(powerline-shell $?)
  fi
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
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  

[ -s "/etc/grc.bashrc" ] && . /etc/grc.bashrc

[ -f ~/.config/ripgrep/ripgreprc ] && export RIPGREP_CONFIG_PATH=$HOME/.config/ripgrep/ripgreprc

if command -v rg >/dev/null; then
  export FZF_DEFAULT_COMMAND="rg --files"
fi

if [ -d "/Applications/DevDesktop/tools" ]; then
  export PATH="$PATH:/Applications/DevDesktop/tools"
fi

if [ -d "$HOME/.node_modules_global/bin" ]; then
  export PATH="$HOME/.node_modules_global/bin:$PATH"
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

if [ -d /usr/local/opt/mysql-client/bin ]; then
  export PATH="/usr/local/opt/mysql-client/bin:$PATH"
fi

if command -v pyenv >/dev/null; then
  eval "$(pyenv init -)"
fi

if [ -d "$HOME/.local/bin" ]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/npm/bin" ]; then
  export PATH="$PATH:$HOME/npm/bin"
  export NODE_PATH="$NODE_PATH:$HOME/npm/lib/node_modules"
fi
