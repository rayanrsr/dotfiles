#!/usr/bin/env bash

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
  sketchybar --set $NAME \
    background.drawing=on \
    background.color=0xeeffffff \
    icon.color=0xff000000 \
    label.color=0xff000000
else
  sketchybar --set $NAME \
    background.drawing=off \
    icon.color=0xccffffff \
    label.color=0xccffffff
fi
