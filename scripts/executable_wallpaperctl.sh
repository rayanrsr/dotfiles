#!/usr/bin/env bash

set -euo pipefail

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/wallpapers}"
INTERVAL_SECONDS="${INTERVAL_SECONDS:-600}"
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/hyprpaper"
STATE_FILE="$STATE_DIR/index"

mkdir -p "$STATE_DIR"

discover_wallpapers() {
  mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)
}

discover_wallpapers

if [ ${#wallpapers[@]} -eq 0 ]; then
  echo "No wallpapers found in $WALLPAPER_DIR" >&2
  exit 1
fi

load_index() {
  if [ -f "$STATE_FILE" ]; then
    cat "$STATE_FILE"
  else
    echo 0
  fi
}

save_index() {
  echo "$1" > "$STATE_FILE"
}

# Check if a given image path is already loaded in hyprpaper
is_loaded() {
  local path="$1"
  hyprctl hyprpaper listloaded 2>/dev/null | grep -F -- "$path" >/dev/null
}

# Preload an image if not already loaded
preload_if_needed() {
  local path="$1"
  if ! is_loaded "$path"; then
    hyprctl hyprpaper preload "$path" >/dev/null 2>&1 || true
  fi
}

# Preload all images found in wallpaper directory
preload_all() {
  for wp in "${wallpapers[@]}"; do
    ext="${wp##*.}"
    if [ "${ext,,}" = "png" ]; then
      preload_if_needed "$wp"
    fi
  done
}

set_wallpaper() {
  local path="$1"
  # Apply to all monitors using hyprpaper runtime command
  preload_if_needed "$path"
  hyprctl hyprpaper wallpaper ", $path" >/dev/null 2>&1 || true
  # Update system colors via pywal if available
  if command -v wal >/dev/null 2>&1; then
    wal -i "$path" >/dev/null 2>&1 &
  fi
}

next_wall() {
  # Refresh list and try to preload any missing PNGs so new images are ready
  discover_wallpapers
  if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR" >&2
    return 1
  fi
  preload_all
  local idx=$(load_index)
  idx=$(( (idx + 1) % ${#wallpapers[@]} ))
  save_index "$idx"
  set_wallpaper "${wallpapers[$idx]}"
}

prev_wall() {
  # Refresh list and try to preload any missing PNGs so new images are ready
  discover_wallpapers
  if [ ${#wallpapers[@]} -eq 0 ]; then
    echo "No wallpapers found in $WALLPAPER_DIR" >&2
    return 1
  fi
  preload_all
  local idx=$(load_index)
  idx=$(( (idx - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]} ))
  save_index "$idx"
  set_wallpaper "${wallpapers[$idx]}"
}

current_wall() {
  local idx=$(load_index)
  echo "${wallpapers[$idx]}"
}

daemon() {
  # Ensure all wallpapers are preloaded first
  preload_all
  # Start by setting current wallpaper
  set_wallpaper "$(current_wall)"
  while true; do
    sleep "$INTERVAL_SECONDS"
    next_wall
  done
}

usage() {
  cat <<EOF
Usage: $(basename "$0") [command]
Commands:
  start          Run daemon to auto-rotate wallpapers
  next           Switch to next wallpaper
  prev           Switch to previous wallpaper
  preload-all    Preload all PNG wallpapers in directory
  current        Print current wallpaper path
Env:
  WALLPAPER_DIR      Directory containing wallpapers (default: $HOME/wallpapers)
  INTERVAL_SECONDS   Rotation interval for start (default: 600)
EOF
}

cmd="${1:-start}"
case "$cmd" in
  start)
    daemon &
    ;;
  next)
    next_wall
    ;;
  prev)
    prev_wall
    ;;
  preload-all)
    preload_all
    ;;
  current)
    current_wall
    ;;
  *)
    usage
    exit 1
    ;;
esac


