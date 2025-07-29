#!/bin/bash

# Break Reminder System
# Reminds user to take a 10-minute break every hour

BREAK_DIR="$HOME/.local/share/break-reminder"
STATUS_FILE="$BREAK_DIR/status"
TIMER_FILE="$BREAK_DIR/timer"

# Create directory if it doesn't exist
mkdir -p "$BREAK_DIR"

# Initialize status if not exists
if [[ ! -f "$STATUS_FILE" ]]; then
    echo "work" > "$STATUS_FILE"
fi

# Function to send notification
send_notification() {
    local title="$1"
    local message="$2"
    local urgency="${3:-normal}"
    
    # Use swaync if available, fallback to notify-send
    if command -v swaync-client &> /dev/null; then
        swaync-client -n "$title" -b "$message"
    else
        notify-send -u "$urgency" "$title" "$message"
    fi
}

# Function to play sound (optional)
play_sound() {
    if command -v paplay &> /dev/null && [[ -f /usr/share/sounds/freedesktop/stereo/complete.oga ]]; then
        paplay /usr/share/sounds/freedesktop/stereo/complete.oga &
    fi
}

case "${1:-auto}" in
    "start-break")
        echo "break" > "$STATUS_FILE"
        echo "$(date +%s)" > "$TIMER_FILE"
        send_notification "🧘 Break Time!" "Time for a 10-minute break! Get up, stretch, hydrate!" "critical"
        play_sound
        # Schedule end of break
        (sleep 600 && "$0" end-break) &
        ;;
        
    "end-break")
        echo "work" > "$STATUS_FILE"
        rm -f "$TIMER_FILE"
        send_notification "💼 Back to Work" "Break time is over. Ready to be productive!" "normal"
        ;;
        
    "skip-break")
        echo "work" > "$STATUS_FILE"
        rm -f "$TIMER_FILE"
        send_notification "⏭️ Break Skipped" "Break reminder skipped. Next break in 1 hour." "low"
        ;;
        
    "status")
        if [[ -f "$STATUS_FILE" ]]; then
            cat "$STATUS_FILE"
        else
            echo "work"
        fi
        ;;
        
    "time-left")
        if [[ -f "$TIMER_FILE" ]] && [[ "$(cat "$STATUS_FILE")" == "break" ]]; then
            start_time=$(cat "$TIMER_FILE")
            current_time=$(date +%s)
            elapsed=$((current_time - start_time))
            remaining=$((600 - elapsed))
            
            if [[ $remaining -gt 0 ]]; then
                echo "$remaining"
            else
                echo "0"
            fi
        else
            echo "0"
        fi
        ;;
        
    "auto"|*)
        # Called by systemd timer every hour
        current_status=$(cat "$STATUS_FILE" 2>/dev/null || echo "work")
        
        if [[ "$current_status" == "work" ]]; then
            "$0" start-break
        fi
        ;;
esac