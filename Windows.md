# Windows

- Install Wox comme launcher / changer son theme par default / changer le keybding par default a Alt + Espace
- Installer GlazeWM / update la configuration se situant a C:/Users/<USER>/.glaze-wm/config.yaml
- Windows Terminal themes : https://terminalsplash.com/
- Telecharger des fonts patches : https://github.com/ryanoasis/nerd-fonts/blob/master/readme.md
- Lancer les scripts setup de WSL
- Creer un raccourci pour Window Terminal : l'executable se trouve ici : %LocalAppData%\Microsoft\WindowsApps, y aller, creer un shortcut sur le bureau, ouvrir les proprietes du shortcut et y associer le hotkey voulu (par exemple Alt + Entree)
- Se debarasser de la task bar : https://github.com/valinet/ExplorerPatcher/releases


## Setup Alacritty on Windows :
### If using ArchWSL :
wsl --set-default Arch

To use WSL, go to %APPDATA%\alacritty\alacritty.yml, and set to use bash shell:

shell:
 program: "C:\\Windows\\System32\\wsl.exe"

