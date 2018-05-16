# My dotfiles and helper scripts

## Requirements
* GNU Stow

## Usage
* Checkout to ~/.dotfiles (or wherever, it's smart enough)
* Run install.sh [options]

If it's in the recommended place (directly under your $HOME) then you can add or
remove individual configurations with

    stow [-D] <package>

## Notes
Don't move the checkout location after install or you'll break the symlinks.
The install script takes options which are passed on to Stow. Typically the only
one needed will be `-D` for removing all the links.

