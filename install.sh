#!/usr/bin/env bash

install_path=${BASH_SOURCE%/*}

if ! command -v stow &> /dev/null; then
  printf "Please install the 'stow' package.\n"
  exit 1
fi

mkdir -p "$HOME/bin"

stow="$(command -v stow) -t $HOME $*"

if ! cd "$install_path"; then
  printf "Could not find dotfiles directory.\n"
  exit 1
fi

for package in $(find . -maxdepth 1 -type d \! -name \.git \! -name \. -exec basename {} \;); do
  $stow "$package"
done

vim +PlugInstall +qall

warn_if_missing() {
  if ! command -v "$1" >/dev/null; then
    if [ -z "$started" ]; then
      printf "The following recommended packages are missing from the system:\n"
      started="true"
    fi

    printf "%s\n" "${2:-$1}"
  fi
}

warn_if_missing bat
warn_if_missing delta git-delta
warn_if_missing fzf
warn_if_missing gitmux
warn_if_missing rg ripgrep
warn_if_missing starship
warn_if_missing tmux
warn_if_missing zsh
