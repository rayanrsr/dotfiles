#!/usr/bin/env bash
# Applies the noctalia KDE color scheme plus a matching Papirus folder theme, then notifies
# running KDE apps. Replaces noctalia's built-in kcolorscheme step because Dolphin only
# re-fetches file-view icons on a palette change, so the icon theme must be switched first.
set -euo pipefail
shopt -s nullglob

scheme=$1
src=/usr/share/icons/Papirus
icons="${XDG_DATA_HOME:-$HOME/.local/share}/icons"
# Rapid theme switches start overlapping runs; serialise them.
exec 9> "${XDG_RUNTIME_DIR:-/tmp}/noctalia-kde-apply.lock"
flock 9

rgb_hex() { IFS=, read -r r g b <<< "$1"; printf '#%02x%02x%02x' "$r" "$g" "$b"; }
main_rgb=$(kreadconfig6 --file "$scheme" --group Colors:Selection --key BackgroundNormal)
main=$(rgb_hex "$main_rgb")
symbol=$(rgb_hex "$(kreadconfig6 --file "$scheme" --group Colors:Selection --key ForegroundNormal)")
# Papirus tab colour is ~13% darker than the folder body.
IFS=, read -r r g b <<< "$main_rgb"
tab=$(printf '#%02x%02x%02x' $((r * 87 / 100)) $((g * 87 / 100)) $((b * 87 / 100)))

# Qt caches icons per theme name, so each palette gets its own name.
name="Papirus-Noctalia-${main#\#}"
dest="$icons/$name"
build="$dest.new"
rm -rf "$build"
dirs=()
for places in "$src"/*/places; do
  size=$(basename "$(dirname "$places")")
  mkdir -p "$build/$size/places"
  # Copy Papirus' alias symlinks too (folder, inode-directory, folder-downloads, ...);
  # those not ending on a blue folder dangle and are pruned below.
  find "$places" -maxdepth 1 -type l -exec cp -P -t "$build/$size/places" {} +
  for f in "$places"/folder-blue*.svg "$places"/user-blue*.svg; do
    [[ -L $f ]] || cp "$f" "$build/$size/places/"
  done
  dirs+=("$size/places")
done
find "$build" -xtype l -delete
find "$build" -type f -name '*.svg' -exec \
  sed -i -e "s/#5294e2/$main/gI" -e "s/#4877b1/$tab/gI" -e "s/#1d344f/$symbol/gI" {} +
{
  printf '[Icon Theme]\nName=%s\nInherits=Papirus-Dark,breeze-dark,hicolor\nDirectories=%s\n' \
    "$name" "$(IFS=,; echo "${dirs[*]}")"
  for d in "${dirs[@]}"; do
    scale=1
    [[ $d == *@2x/* ]] && scale=2
    printf '\n[%s]\nContext=Places\nSize=%s\nScale=%s\nType=Fixed\n' "$d" "${d%%x*}" "$scale"
  done
} > "$build/index.theme"
rm -rf "$dest"
mv "$build" "$dest"

# KDE apps only re-read kdeglobals on PaletteChanged (0), act on IconChanged (4) with whatever
# they last read, and Dolphin's file view re-fetches icons only when the palette really
# changes. So: publish the icon theme, re-read + switch icons, then change the palette.
notify() { dbus-send --session --type=signal /KGlobalSettings org.kde.KGlobalSettings.notifyChange "int32:$1" int32:0; }
kwriteconfig6 --file kdeglobals --group Icons --key Theme "$name"
notify 0
notify 4
sleep 1

# Merge every scheme group into kdeglobals ("[Colors:Header][Inactive]" is a nested group).
groups=()
while IFS= read -r line; do
  if [[ $line =~ ^\[(.*)\]$ ]]; then
    IFS=$'\n' read -r -d '' -a groups < <(sed 's/\]\[/\n/g' <<< "${BASH_REMATCH[1]}") || true
  elif [[ $line == *=* && ${groups[0]} != General ]]; then
    args=()
    for g in "${groups[@]}"; do args+=(--group "$g"); done
    kwriteconfig6 --file kdeglobals "${args[@]}" --key "${line%%=*}" "${line#*=}"
  fi
done < "$scheme"
kwriteconfig6 --file kdeglobals --group General --key ColorScheme Noctalia
notify 0

find "$icons" -maxdepth 1 -name 'Papirus-Noctalia*' ! -name "$name" -exec rm -rf {} +
