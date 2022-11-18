export EDITOR=vim
export VISUAL=vim
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
export DISABLE_AUTO_TITLE=true

set -o noclobber

setup_grep() {
  if [ -f ~/.config/ripgrep/ripgreprc ]; then
    export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
  fi
}

setup_x() {
  if [ "$OSTYPE" = "linux-gnu"  -a -z "$DISPLAY" -a -n "$SSH_CLIENT" ]; then
    export DISPLAY="$(echo "$SSH_CLIENT" | cut -f1 -d\ ):0.0"
  elif [ "$OSTYPE" = "linux-gnu"  -a -z "$DISPLAY" ]; then
    export DISPLAY="192.168.0.46:0.0"
  fi
}

setup_path() {
  # I can't remember what installs itself here but something used to, so...
  if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
  fi

  # Local-user PEAR.
  if [ -d "$HOME/pear/bin" ]; then
    PATH="$HOME/pear/bin:$PATH"
  fi

  # Oh you wacky MacOS, you.
  if [ -d /Applications/DevDesktop/tools ]; then
    PATH="$PATH:/Applications/DevDesktop/tools"
  fi

  # Oh you wacky homebrew, you.
  if [ -d /usr/local/opt/php@8.0/bin ]; then
    export PATH="/usr/local/opt/php@8.0/bin:$PATH"
  fi

  # Prioritise GNU binaries installed through Homebrew on MacOS.
  if [ -d "/usr/local/opt/grep/libexec/gnubin" ]; then
    PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  fi

  if [ -d "/usr/local/opt/mysql-client/bin" ]; then
    PATH="/usr/local/opt/mysql-client/bin:$PATH"
  fi

  if [ -d "$HOME/.gem/ruby/2.0.0/bin" ]; then
    PATH="$HOME/.gem/ruby/2.0.0/bin:$PATH"
  fi

  if [ -d "$HOME/vendor/bin" ]; then
    PATH="$HOME/vendor/bin:$PATH"
  fi

  if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
  fi

  if [ -d "$HOME/.npm/bin" ]; then
    PATH="$HOME/.npm/bin:$PATH"
  fi

  if [ -d "$HOME/Sync/bin" ]; then
    PATH="$HOME/Sync/bin:$PATH"
  fi

  if [ -d "$HOME/bin" ]; then
    PATH="$HOME/bin:$PATH"
  fi

  export PATH
}

setup_aliases() {
  [ -f ~/.aliases ] && . ~/.aliases
  [ -f ~/shore-projects/shore-aliases.sh ] && . ~/shore-projects/shore-aliases.sh
}

setup_colors() {
  export LS_COLORS='rs=0:di=30;44:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=30;43:st=37;44:ex=03;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:';

  # Set colors for less. Borrowed from https://wiki.archlinux.org/index.php/Color_output_in_console#less
  export LESS_TERMCAP_mb=$'\E[1;31m'     # begin bold
  export LESS_TERMCAP_md=$'\E[1;36m'     # begin blink
  export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
  export LESS_TERMCAP_so=$'\E[01;44;33m' # begin reverse video
  export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
  export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
  export LESS_TERMCAP_ue=$'\E[0m'        # reset underline
  export LESS='-F -i -J -M -R -W -x4 -X -z-4'
}

setup_node_environment() {
  export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
    [ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  

  if [ -d "$HOME/npm/bin" ]; then
    export PATH="$PATH:$HOME/npm/bin"
    export NODE_PATH="$NODE_PATH:$HOME/npm/lib/node_modules"
  fi

  if [ -d "$HOME/.npm-global/bin" ]; then
    export PATH="$PATH:$HOME/.npm-global/bin"
    export NODE_PATH="$NODE_PATH:$HOME/npm-global/lib/node_modules"
  fi

  if [ -d "$HOME/.yarn/bin" ]; then
    export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
  fi

  if [ -f "/usr/share/nvm/init-nvm.sh" ]; then
    source /usr/share/nvm/init-nvm.sh
  fi

  if command -v nvm >/dev/null; then
    nvm use node >/dev/null
  fi
}

setup_python_environment() {
	if [ -x "$PYENV_ROOT/bin/pyenv" ]; then
		export PYENV_ROOT="$HOME/.pyenv"
		export PATH="$PYENV_ROOT/bin:$PATH"
		eval "$(pyenv init --path)"
	fi

  if [ -d "$HOME/.poetry/bin" ]; then
    export PATH="$HOME/.poetry/bin:$PATH"
  fi
}

setup_fuzzy_finder() {
  if command -v rg >/dev/null; then
    export FZF_DEFAULT_COMMAND="rg --files"
  fi

  [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}

funky_motd() {
  printer="cat"
  filter="cat"

  if command -v toilet >/dev/null; then
    printer="toilet -t -f future"
  elif command -v figlet >/dev/null; then
    printer="figlet"
  fi

  if command -v lolcat >/dev/null; then
    filter="lolcat -S $(hostname | shasum | tr -d '[a-f]' | cut -b-4)"
  fi

  printf "\n"
  eval "echo $* | $printer | $filter"
  printf "\n"
}

display_host_info() {
  # My work laptop has a dumb corporate name.
  if [[ "$(hostname)" =~ "\.local$" ]]; then
    funky_motd "Macbook"
  elif [ -n "$SSH_CLIENT" -o -n "$SSH_TTY" ]; then
    funky_motd "$(hostname)"

  # WSL leaves you in the stupid Windows home.
  elif [ -d /mnt/c/Windows ]; then
    cd

    funky_motd "arcade"
  fi
}

setup_prompt() {
  if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
  fi
}

setup_editor() {
  if [ -d /usr/local/share/vim/vim80 ]; then
    export VIMRUNTIME=/usr/local/share/vim/vim80
  fi
}

setup_autocomplete() {
  autoload -Uz compinit && compinit
  zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*'
}

set_key_bindings() {
  bindkey -e

  bindkey "\e[H" beginning-of-line
  bindkey "\e[F" end-of-line
  bindkey "\e[1;5D" backward-word
  bindkey "\e[1;5C" forward-word
  bindkey "\e[A" history-search-backward
  bindkey "\e[B" history-search-forward

  # Remote-specific settings.
  if [ -z "$SSH_CLIENT" -a -z "$SSH_TTY" ]; then
    if [ "$OSTYPE" = "linux-gnu" ]; then
      # xinitrc/xsessionrc don't work on PopOS :/
      if command -v setxkbmap > /dev/null; then
        setxkbmap -option caps:escape
      fi
    fi
  fi
}

set_timezone() {
  export TZ='Europe/London'
}

disable_nanny_mode() {
  # -f means -f and don't you forget it.
  setopt localoptions rmstarsilent
}

display_host_info
setup_node_environment 
setup_python_environment 
setup_fuzzy_finder 
setup_path
setup_colors
setup_grep
setup_editor
setup_prompt
setup_aliases
setup_autocomplete
setup_x
set_key_bindings
set_timezone
disable_nanny_mode

