alias dropbox-restart='dropbox stop && DBUS_SESSION_BUS_ADDRESS="" dropbox start'
alias egrep='egrep --colour=auto'
alias fgrep='fgrep --colour=auto'
alias gti='git'
alias grep='grep --colour=auto'
alias ncdu='ncdu --color dark -rr -x'
alias pacman='pacman --color=auto'
alias pdown='cd && fusermount -u ~/.visible && history -c && history -w && clear'
alias pup='cd && clear && encfs ~/.crypt ~/.visible'
alias vi='vim'
alias tree='tree -C -I $(git check-ignore * 2>/dev/null | tr "\n" "|").git'

case $OSTYPE in 
  linux-gnu)
    alias ls='ls --color --group-directories-first -FhN'
    ;;
  darwin*)
    alias ls='ls -FhG'
  ;;
esac
