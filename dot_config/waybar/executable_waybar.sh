#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch waybar for each monitor
waybar -c ~/.config/waybar/config-dp1 &
waybar -c ~/.config/waybar/config-dp2 &
