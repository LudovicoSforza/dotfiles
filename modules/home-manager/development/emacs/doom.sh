#!/usr/bin/env sh

DOOM="$HOME/.emacs.d"

if [ ! -d "$DOOM" ]; then
  git clone https://github.com/hlissner/doom-emacs.git $DOOM
  yes | $DOOM/bin/doom install
else
  $DOOM/bin/doom sync
fi

# Check if emacs daemon is running
# if it is running then pkill it 
# if it is not then run the daemon
if pgrep -x "emacs" > /dev/null
then
    pkill emacs
    emacs --daemon
else
    emacs --daemon
fi

