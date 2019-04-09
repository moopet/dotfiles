#!/usr/bin/env bash

install_path=${BASH_SOURCE%/*}

if ! command -v stow &> /dev/null; then
  echo "Please install the 'stow' package."
  exit 1
fi

mkdir -p "$HOME/bin"

stow="$(command -v stow) -t $HOME $*"

if ! cd "$install_path"; then
  echo "Could not find dotfiles directory."
  exit 1
fi

find . -maxdepth 1 -type d \! -name \.git \! -name \. -exec basename {} \; | xargs $stow
