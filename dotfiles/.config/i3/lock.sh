#!/bin/bash
# original: http://pastebin.com/ZpYghBkQ 
# credit: https://www.reddit.com/r/unixporn/comments/3358vu/i3lock_unixpornworthy_lock_screen/cqk4uua
# note: I removed the code that puts the lock icon over the screen.

scrot /tmp/screen.png
convert /tmp/screen.png -scale 10% -scale 1000% /tmp/screen.png
 
# dbus-send --print-reply --dest=org.mpris.MediaPlayer2.spotify /org/mpris/MediaPlayer2 org.mpris.MediaPlayer2.Player.Stop
# i3lock  -I 10 -d -e -u -n -i /tmp/screen.png

# -d turns the screen off
i3lock -d -e -u -n -i /tmp/screen.png