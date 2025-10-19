<div align="center">
    <h1>Windows</h1>
</div>

# Summary :
- Fetch Script : neoFetch
- Editor : Neovim
- Terminal : Alacritty
- Window Manager : GlazeWM
- Status Bar : GlazeWM bar
- Terminal Multiplexer : Tmux
- Hotkeys : Managed by GlazeWM
- Launcher : Wox
- Fonts : Fira Code, JetBrains Mono, SF Mono, Nerd Fonts
- Color Scheme : Catppuccin Mocha
- Zsh Theme : Powerlevel10k
- Other Terminal Utilities : Bat, Exa, Fzf, Ripgrep, Starship, Tldr, Zoxide, Lsd, LazyGit

# How to 
- Install [WSL](https://learn.microsoft.com/en-us/windows/wsl/install).
- Install [Wox](https://github.com/Wox-launcher/Wox/releases) Launcher.
- Install [GlazeWM](https://github.com/glazerdesktop/GlazeWM)
- Put this [file](https://github.com/rayanramoul/RayTerm/blob/master/dotfiles/.glaze-wm/config.yaml) in your C:/Users/<USER>/.glaze-wm/config.yaml
- Download [Alacritty](https://github.com/alacritty/alacritty/releases] on Windows or get Windos Terminal and some [themes](https://terminalsplash.com/).
- Download and install the [fonts](https://github.com/rayanramoul/RayTerm/tree/master/dotfiles/.fonts).
- To use WSL as default in Alacritty : rrun wsl --set-default Arch
- And then go to %APPDATA%\alacritty\alacritty.yml, and put this [config](https://github.com/rayanramoul/RayTerm/blob/master/dotfiles/.config/alacritty/alacritty.yml) and uncomment the  line for WSL shell
- Install  [ExplorerPatcher](https://github.com/valinet/ExplorerPatcher/releases) to get rid of the Windows Task Bar.
- Then inside your WSL you can run the command :

```bash
sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"
```
The script will clone this repository and install ansible then prompt you to choose which part of the install you want to run. <br>
If you only want to check the dotfiles you can get them at this link : [Dotfiles](dotfiles) and for example run [Stow](https://www.gnu.org/software/stow/) to symlink your config with the repositories ones :
```bash
git clone https://github.com/rayanramoul/RayTerm/
cd RayTerm
stow -t $HOME -R dotfiles
```
