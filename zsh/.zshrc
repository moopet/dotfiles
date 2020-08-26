export EDITOR=vim
export VISUAL=vim
export PATH=$HOME/bin:$HOME/.gem/ruby/2.0.0/bin:$HOME/vendor/bin:$PATH
export LC_CTYPE=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

set -o noclobber

setup_grep() {
  if [ -f ~/.config/ripgrep/ripgreprc ]; then
    export RIPGREP_CONFIG_PATH="$HOME/.config/ripgrep/ripgreprc"
  fi
}

setup_path() {
  # I can't remember what installs itself here but something used to, so...
  if [ -d "$HOME/.local/bin" ]; then
    export PATH="$HOME/.local/bin:$PATH"
  fi

  # Oh you wacky MacOS, you.
  if [ -d /Applications/DevDesktop/tools ]; then
    export PATH="$PATH:/Applications/DevDesktop/tools"
  fi

  # Prioritise GNU binaries installed through Homebrew on MacOS.
  if [ -d "/usr/local/opt/grep/libexec/gnubin" ]; then
    export PATH="/usr/local/opt/grep/libexec/gnubin:$PATH"
  fi

  if [ -d /usr/local/opt/mysql-client/bin ]; then
    export PATH="/usr/local/opt/mysql-client/bin:$PATH"
  fi
}

setup_aliases() {
  [ -f ~/.aliases ] && . ~/.aliases
  [ -f ~/shore-projects/shore-aliases.sh ] && . ~/shore-projects/shore-aliases.sh
}

setup_colors() {
  export LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=37;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.dz=01;31:*.gz=01;31:*.lz=01;31:*.xz=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.jpg=01;35:*.jpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.axv=01;35:*.anx=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.axa=00;36:*.oga=00;36:*.spx=00;36:*.xspf=00;36:'

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
}

setup_python_environment() {
  if command -v pyenv >/dev/null; then
    eval "$(pyenv init -)"
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
  elif [ -d /mnt/c/WINDOWS ]; then
    cd

    funky_motd "arcade"
  fi
}

setup_helpers() {
  if command -v thefuck >/dev/null; then
    eval "$(thefuck --alias)"
  fi
}

setup_prompt() {
  if command -v starship > /dev/null; then
    eval "$(starship init zsh)"
  fi
}

display_host_info
setup_node_environment 
setup_python_environment 
setup_fuzzy_finder 
setup_path
setup_colors
setup_grep
setup_prompt
setup_helpers
setup_aliases
