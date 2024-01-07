#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item
#!/usr/bin/env bash
BLACK=0xff24283b
WHITE=0xffa9b1d6
MAGENTA=0xffbb9af7
BLUE=0xff7aa2f7
CYAN=0xff7dcfff
GREEN=0xff9ece6a
YELLOW=0xffe0af68
ORANGE=0xffff9e64
RED=0xfff7768e
BAR_COLOR=0xff1a1b26
COMMENT=0xff565f89

SPACE_ICONS=(
    " " 
    " " 
    " " 
    " " 
    " " 
    " " 
    "" 
    "" 
    "" 
    ""
)
SPACE_CLICK_SCRIPTS=(
    "alacritty",
    "firefox",
    "spotify",
    "code",
    "slack",
    "vlc",
    "",
    "",
    "",
    ""
)
if [ "$SELECTED" = "true" ]; then
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$RED" \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
else
	sketchybar --animate tanh 5 --set "$NAME" \
		icon.color="$COMMENT" \
		icon="${SPACE_ICONS[$SID - 1]}" \
		click_script="$SPACE_CLICK_SCRIPT"
fi
