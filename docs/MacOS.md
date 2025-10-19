<div align="center">
    <h1>MacOS</h1>
</div>

# Table of Content
- [Tiling Window Management](#how-to-have-tiling-window-management-and-keybindings)
- [Setup Top Bar](#setup-a-top-bar)
- [My Dotfiles](#get-my-dotfiles)
- [Essential Apps](#essential-apps)
- [Other Interesting Apps](#other-interesting-apps)

# Summary :
- Fetch Script : neoFetch
- Editor : Neovim
- Terminal : Alacritty
- Window Manager : Yabai
- Status Bar : Simple Bar
- Terminal Multiplexer : Tmux
- Hotkeys : Skhd
- Launcher : Raycast
- Fonts : Fira Code, JetBrains Mono, SF Mono, Nerd Fonts
- Color Scheme : Catppuccin Mocha
- Zsh Theme : Powerlevel10k
- Other Terminal Utilities : Bat, Exa, Fzf, Ripgrep, Starship, Tldr, Zoxide, Lsd, LazyGit

# How To Have Tiling Window Management and Keybindings
- Install [Yabai](https://github.com/koekeishiya/yabai) Tiling Window Manager, follow this [Tutorial](https://github.com/koekeishiya/yabai/wiki/Installing-yabai-(from-HEAD)) for example.
- (Optional) Another Tiling WM alternative is Amethyst but Yabai is better : https://brandonkboswell.com/blog/Mouseless-MacOS-Window-Management-Yabai-vs-Amethyst/
- (For Apple Silicon users) If you are using a Mac with Apple Silicon you will have to run this : sudo nvram boot-args=-arm64e_preview_abi
- Install [SKHD](https://github.com/koekeishiya/skhd) to set Yabai and system keybinds.

# Setup a Top Bar
You have 2 options :
## First Option - Simple Bar (Simple)
Works better out of the box without too much config or hassle.
- Install [Uebersicht](http://tracesof.net/uebersicht/) this launcher will be helpful to setup the top bar.
- Install [Simple-Bar](https://github.com/Jean-Tinland/simple-bar), then you can configure it by clicking on it then CMD + ,
- Another potential bar is [Sketchy Bar](https://github.com/FelixKratz/SketchyBar/tree/master).

## Second Option - SketchyBar (Similar to i3wm or GlazeWM bars)
I prefer it, configuration is a yaml file saved in ~/.config and also it better follows the behaviours of other twm i use
- Install following [this](https://github.com/FelixKratz/SketchyBar)


# (Optional) Have highlights on borders of apps to know which one is selected
- Install [Janky-Border](https://github.com/FelixKratz/JankyBorders) this will help to highlight focused windows.
- Goo to System Prefs > Mission Control,
- Uncheck - Automatically rearrange
- Check - Displays have separate spaces

# Get my dotfiles
The dotfiles specific to Mac are mostly yabai [config](https://github.com/rayanramoul/RayTerm/blob/master/dotfiles/.config/yabai/yabairc) and skhd [config](https://github.com/rayanramoul/RayTerm/blob/master/dotfiles/.config/skhd/skhdrc) and sketchy bar [config](https://github.com/rayanramoul/RayTerm/blob/master/dotfiles/.config/sketchybar/sketchybarrc) ones, i reproduce with them what i have on i3wm and glazewm.
## First Option - With install.sh script
- Setup dotfiles, in your terminal launch :
```bash
sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"
```
The script will clone this repository and install ansible then prompt you to choose which part of the install you want to run. <br>

## Second Option - Use Stow
If you only want to check the dotfiles you can get them at this link : [Dotfiles](dotfiles) and for example run [Stow](https://www.gnu.org/software/stow/) to symlink your config with the repositories ones :
```bash
git clone https://github.com/rayanramoul/RayTerm/
cd RayTerm
stow -t $HOME -R dotfiles
```
- Now reload yabai and skbhd services
```bash
yabai --restart-service
skhd --restart-service
```

# Essential Apps
- Keeps Computer not sleepy : https://apps.apple.com/fr/app/amphetamine/id937984704?mt=12
- Mac native search is really limited, get a better spotlight (search for apps, folders and more) : https://manual.raycast.com/
- (Optional) another spotlight alternative is [Alfred](https://www.alfredapp.com/), comparison between the 2 : https://joshcollinsworth.com/blog/alfred-raycast
- Better Screenshot tool : https://shottr.cc/
- Best terminal for Mac (I personally use Alacritty for cross-platform support) : https://www.warp.dev/


# Other Interesting Apps
- Resize windows like in Windows (install it if you didn't setup Tiling Window Management) : https://rectangleapp.com/
- Test of camera : https://apps.apple.com/us/app/hand-mirror/id1502839586?mt=12
- Bind hotkeys : https://apps.apple.com/fr/app/hotkey-app/id975890633?mt=12
- Optimize images sizes : https://imageoptim.com/mac
- Save apps for later to prepare calls/sharing screen : https://getlater.app/
- Download latest versions of apps : https://max.codes/latest/
- Read articles : https://quietreader.app/
- Get commands recommendations in Terminal (install it if you you are using something else than Warp terminal) : https://youtu.be/ynL1fYncZ1E and https://github.com/zsh-users/zsh-completions and https://fig.io/
- If you prefer another terminal than Warp you can still setup [Fig.io](https://fig.io/)

# Keybinds
My keybindgs are the same accross all the OSs i use, you can find a recap of them [here](https://github.com/rayanramoul/RayTerm/blob/master/docs/Keybindings.md)
