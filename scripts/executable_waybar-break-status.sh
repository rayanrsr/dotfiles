#!/bin/bash

# Waybar Break Status Module
# Shows current break status and countdown

BREAK_SCRIPT="$HOME/.local/share/chezmoi/scripts/executable_break-reminder.sh"

# Get current status
status=$("$BREAK_SCRIPT" status)
time_left=$("$BREAK_SCRIPT" time-left)

case "$status" in
    "break")
        if [[ "$time_left" -gt 0 ]]; then
            minutes=$((time_left / 60))
            seconds=$((time_left % 60))
            text="🧘 ${minutes}:$(printf "%02d" $seconds)"
            class="break-active"
            tooltip="Break time! ${minutes}:$(printf "%02d" $seconds) remaining"
        else
            text="🧘 Break"
            class="break-active"
            tooltip="Break time is over"
        fi
        ;;
    *)
        text="💼 Work"
        class="work"
        tooltip="Working time - next break at the top of the hour"
        ;;
esac

# Output JSON for waybar
echo "{\"text\":\"$text\", \"class\":\"$class\", \"tooltip\":\"$tooltip\"}"