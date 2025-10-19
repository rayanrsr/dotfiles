#!/bin/bash

current_space=$(yabai -m query --spaces --space | jq -r .index)

if [ -z "$PREVIOUS_SPACE" ]; then
    export PREVIOUS_SPACE=$current_space
else
    if [ "$current_space" != "$PREVIOUS_SPACE" ]; then
        yabai -m space --focus $PREVIOUS_SPACE
        export PREVIOUS_SPACE=$current_space
    fi
fi
