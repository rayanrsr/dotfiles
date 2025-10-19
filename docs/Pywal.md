# Pywal Integration

This setup automatically updates your system colors based on your wallpaper using [pywal](https://github.com/dylanaraps/pywal).

## What Gets Themed

When you change your wallpaper, pywal will automatically update:
- **Waybar** - Status bar colors
- **Ulauncher** - Application launcher colors
- **swaync** - Notification center (optional)

## How It Works

1. The `wallpaperctl.sh` script runs `wal -i <wallpaper>` when changing wallpapers
2. Pywal analyzes the wallpaper and generates a color scheme
3. The `~/.config/wal/postrun` hook applies colors to waybar and ulauncher
4. Applications are automatically reloaded with new colors

## Installation

### Install pywal

**Arch Linux:**
```bash
sudo pacman -S python-pywal
```

**Ubuntu/Debian:**
```bash
pip install pywal
```

**MacOS:**
```bash
brew install pywal
```

### Apply Configuration

The configuration is already set up in your dotfiles:
- `~/.config/wal/templates/colors-waybar.css` - Waybar template
- `~/.config/wal/templates/colors-ulauncher.css` - Ulauncher template
- `~/.config/wal/postrun` - Post-generation hook

## Manual Usage

### Generate colors from a wallpaper:
```bash
wal -i ~/wallpapers/your-wallpaper.png
```

### Preview colors:
```bash
wal -i ~/wallpapers/your-wallpaper.png --preview
```

### Use a specific backend:
```bash
# Colorz (default)
wal -i ~/wallpapers/your-wallpaper.png

# Colorthief
wal -i ~/wallpapers/your-wallpaper.png --backend colorthief

# Haishoku
wal -i ~/wallpapers/your-wallpaper.png --backend haishoku
```

### Restore previous colors:
```bash
wal -R
```

## Automatic Wallpaper Cycling

Your wallpaper controller (`wallpaperctl.sh`) is already integrated with pywal:

```bash
# Next wallpaper (updates colors automatically)
wallpaperctl.sh next

# Previous wallpaper (updates colors automatically)
wallpaperctl.sh prev
```

Or use the keybinds:
- `SUPER + W` - Next wallpaper
- `SUPER + SHIFT + W` - Previous wallpaper

## Color Scheme Persistence

Pywal saves your current color scheme in `~/.cache/wal/`. To restore colors on login, add to your shell rc:

```bash
# Restore pywal colors
(cat ~/.cache/wal/sequences &)
```

This is already included in your `.zshrc` if you want pywal colors in terminal.

## Customization

### Modify Waybar Colors

Edit `~/.config/wal/templates/colors-waybar.css` to customize how colors are applied.

Pywal provides these variables:
- `{background}` - Background color
- `{foreground}` - Foreground/text color
- `{cursor}` - Cursor color
- `{color0}` - `{color15}` - 16 color palette

### Modify Ulauncher Colors

Edit `~/.config/wal/templates/colors-ulauncher.css` to customize the launcher appearance.

### Add More Applications

Edit `~/.config/wal/postrun` to add more applications that should be themed.

## Troubleshooting

### Colors not updating?

1. Check if pywal is installed:
   ```bash
   wal --version
   ```

2. Check if the postrun hook is executable:
   ```bash
   ls -l ~/.config/wal/postrun
   ```

3. Manually run pywal to see errors:
   ```bash
   wal -i ~/wallpapers/some-image.png
   ```

### Waybar not reloading?

Manually reload waybar:
```bash
killall waybar && waybar &
```

### Ulauncher not updating?

1. Check if pywal theme exists:
   ```bash
   ls ~/.config/ulauncher/user-themes/pywal/
   ```

2. Manually set theme in ulauncher preferences

3. Restart ulauncher:
   ```bash
   killall ulauncher && ulauncher --hide-window &
   ```

## Advanced Configuration

### Custom Color Backends

Install additional backends for better color extraction:

```bash
# Colorthief
pip install colorthief

# Haishoku  
pip install haishoku

# Colorz (C-based, fastest)
pip install colorz
```

Then use with:
```bash
wal -i ~/wallpapers/image.png --backend colorthief
```

### Light/Dark Mode

Force light or dark colors:
```bash
# Dark mode (default)
wal -i ~/wallpapers/image.png

# Light mode
wal -i ~/wallpapers/image.png -l
```

### Saturation Adjustment

Adjust color saturation:
```bash
# Increase saturation
wal -i ~/wallpapers/image.png --saturate 0.8

# Decrease saturation  
wal -i ~/wallpapers/image.png --saturate 0.3
```

## Resources

- [Pywal GitHub](https://github.com/dylanaraps/pywal)
- [Pywal Wiki](https://github.com/dylanaraps/pywal/wiki)
- [Color Schemes](https://github.com/dylanaraps/pywal/wiki/User-Submitted-Color-Schemes)


