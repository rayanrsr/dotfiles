#!/usr/bin/env bash

set -euo pipefail

log_info() { echo "[INFO]  $*" >&2; }
log_warn() { echo "[WARN]  $*" >&2; }
log_error() { echo "[ERROR] $*" >&2; }

WALLPAPER_DIR="${WALLPAPER_DIR:-$HOME/wallpapers}"
INTERVAL_SECONDS="${INTERVAL_SECONDS:-600}"
SHUFFLE_PLAYLIST="${SHUFFLE_PLAYLIST:-0}" # set to 1 to shuffle order at startup
STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/hyprpaper"
STATE_FILE="$STATE_DIR/index"
PLAYLIST_FILE="$STATE_DIR/playlist"

mkdir -p "$STATE_DIR"

wait_for_hyprpaper() {
  # Wait briefly for hyprpaper to start accepting commands
  local attempts=0
  local max_attempts=50 # ~10s
  local notified=0
  while ! hyprctl hyprpaper listloaded >/dev/null 2>&1; do
    if [ "$notified" -eq 0 ]; then
      log_info "waiting for hyprpaper to be ready..."
      notified=1
    fi
    attempts=$((attempts + 1))
    if [ "$attempts" -ge "$max_attempts" ]; then
      # Give up but continue; commands may still succeed later
      log_warn "hyprpaper not responsive after ~10s; continuing anyway"
      break
    fi
    sleep 0.2
  done
}

discover_wallpapers() {
  # Build a fresh snapshot from disk (optionally shuffled)
  local -a fresh
  if [ "$SHUFFLE_PLAYLIST" = "1" ] || [ "$SHUFFLE_PLAYLIST" = "true" ]; then
    mapfile -t fresh < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | shuf)
  else
    mapfile -t fresh < <(find "$WALLPAPER_DIR" -type f \( -iname '*.jpg' -o -iname '*.jpeg' -o -iname '*.png' -o -iname '*.webp' \) | sort)
  fi

  # If a persisted playlist exists, prefer it, but refresh if stale
  if [ -f "$PLAYLIST_FILE" ]; then
    mapfile -t wallpapers <"$PLAYLIST_FILE"
    # If counts differ or any file is missing, rebuild the playlist
    if [ ${#wallpapers[@]} -ne ${#fresh[@]} ]; then
      log_info "playlist is stale (${#wallpapers[@]} cached vs ${#fresh[@]} on disk); rebuilding"
      wallpapers=("${fresh[@]}")
      printf '%s\n' "${wallpapers[@]}" >"$PLAYLIST_FILE"
      return
    fi
    for wp in "${wallpapers[@]}"; do
      if [ ! -f "$wp" ]; then
        log_info "playlist contains missing file; rebuilding"
        wallpapers=("${fresh[@]}")
        printf '%s\n' "${wallpapers[@]}" >"$PLAYLIST_FILE"
        return
      fi
    done
    return
  fi

  # No persisted playlist; persist fresh snapshot
  wallpapers=("${fresh[@]}")
  printf '%s\n' "${wallpapers[@]}" >"$PLAYLIST_FILE"
}

# Force-rebuild playlist (optionally shuffled) and reset index to 0
rebuild_playlist() {
  rm -f "$PLAYLIST_FILE"
  discover_wallpapers
  save_index 0
}

discover_wallpapers

if [ ${#wallpapers[@]} -eq 0 ]; then
  log_error "No wallpapers found in $WALLPAPER_DIR"
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
  echo "$1" >"$STATE_FILE"
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
    log_info "preloading wallpaper $path"
    local out
    if ! out=$(hyprctl hyprpaper preload "$path" 2>&1); then
      log_warn "preload failed for $path: $out"
    fi
  fi
}

# Preload all images found in wallpaper directory
preload_all() {
  wait_for_hyprpaper
  # Show the list that will be preloaded and its total count
  local count=${#wallpapers[@]}
  log_info "will preload $count wallpaper(s) from $WALLPAPER_DIR:"
  printf '%s\n' "${wallpapers[@]}"
  for wp in "${wallpapers[@]}"; do
    preload_if_needed "$wp"
  done
}

set_wallpaper() {
  local path="$1"
  # Apply to all monitors using hyprpaper runtime command
  wait_for_hyprpaper
  preload_if_needed "$path"
  log_info "loading wallpaper $path"
  local out
  if ! out=$(hyprctl hyprpaper wallpaper ", $path" 2>&1); then
    log_error "failed to set wallpaper $path: $out"
  fi
  # Update system colors via pywal if available
  # TODO: enable if you want automatic switch of TERM colors
  # if command -v wal >/dev/null 2>&1; then
  #   wal -i "$path" >/dev/null 2>&1 &
  # fi
}

next_wall() {
  # Refresh list and try to preload any missing PNGs so new images are ready
  discover_wallpapers
  if [ ${#wallpapers[@]} -eq 0 ]; then
    log_error "No wallpapers found in $WALLPAPER_DIR"
    return 1
  fi
  preload_all
  local idx=$(load_index)
  idx=$(((idx + 1) % ${#wallpapers[@]}))
  save_index "$idx"
  set_wallpaper "${wallpapers[$idx]}"
}

prev_wall() {
  # Refresh list and try to preload any missing PNGs so new images are ready
  discover_wallpapers
  if [ ${#wallpapers[@]} -eq 0 ]; then
    log_error "No wallpapers found in $WALLPAPER_DIR"
    return 1
  fi
  preload_all
  local idx=$(load_index)
  idx=$(((idx - 1 + ${#wallpapers[@]}) % ${#wallpapers[@]}))
  save_index "$idx"
  set_wallpaper "${wallpapers[$idx]}"
}

current_wall() {
  local idx=$(load_index)
  echo "${wallpapers[$idx]}"
}

daemon() {
  # Ensure all wallpapers are preloaded first (from persisted or newly created playlist)
  preload_all
  # Start by setting current wallpaper
  set_wallpaper "$(current_wall)"
  while true; do
    sleep "$INTERVAL_SECONDS"
    next_wall
  done
}

# Apply current wallpaper once and exit
apply_once() {
  preload_all
  set_wallpaper "$(current_wall)"
}

usage() {
  cat <<EOF
Usage: $(basename "$0") [command]
Commands:
  start          Apply current wallpaper once and exit
  daemon         Run daemon to auto-rotate wallpapers
  next           Switch to next wallpaper
  prev           Switch to previous wallpaper
  preload-all    Preload all wallpapers in directory
  current        Print current wallpaper path
  reshuffle      Rebuild a shuffled playlist and reset index to 0
Env:
  WALLPAPER_DIR      Directory containing wallpapers (default: $HOME/wallpapers)
  INTERVAL_SECONDS   Rotation interval for daemon (default: 600)
  SHUFFLE_PLAYLIST   1 to shuffle playlist at startup (default: 0)
EOF
}

cmd="${1:-start}"
case "$cmd" in
start)
  apply_once
  ;;
daemon)
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
reshuffle)
  SHUFFLE_PLAYLIST=1 rebuild_playlist
  ;;
*)
  usage
  exit 1
  ;;
esac
