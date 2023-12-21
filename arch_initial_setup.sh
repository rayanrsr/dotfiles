#!/bin/bash

# Arch Linux Initial Setup Script
# This script automates the initial setup of a new Arch Linux installation.

# Display an ASCII header
echo "---------------------------------------------------------"
echo "$$$$$$                      "
echo "$$  __$$\                     "
echo "$$ |  $$ | \$\$\$\$\$\$\\  $$\   $$\\ "
echo "$$$$$$$  | \\____$$\\ $$ |  $$ |"
echo "$$  __$$<  \$\$\$\$\$\$\$ |$$ |  $$ |"
echo "$$ |  $$ |$$  __$$ |$$ |  $$ |"
echo "$$ |  $$ |\\$$$$$$$ |\\$$$$$$$ |"
echo "\__|  \__| \\_______| \\____$$ |"
echo "                    $$\   $$ |"
echo "                    \\$$$$$$  |"
echo "                     \\______/ "
echo "---------------------------------------------------------"


# Update the system and install essential packages
echo "Updating the system and installing essential packages..."
sudo pacman -Syyu --noconfirm
sudo pacman -S --noconfirm \
  firefox tilix nitrogen neofetch wget git lxappearance materia-gtk-theme \
  papirus-icon-theme pavucontrol qt5ct scrot xautolock i3lock ttf-font-awesome \
  ttf-droid pacman-contrib picom i3-wm i3 sysstat

# Install development tools and dependencies
echo "Installing development tools and dependencies..."
sudo pacman -S --noconfirm base-devel linux-headers git


# Install Yay (AUR Helper)
echo "Installing Yay..."
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ~

# Install additional packages from AUR using Yay
echo "Installing additional packages from AUR..."
yay -S --noconfirm \
  discord neovim vscodium lutris feh heroic-games-launcher-bin wine htop \
  mangohud gamemode flameshot rofi compton dmenu arandr thunderbird-nightly-bin traansmission-qt

# Install Miniconda
echo "Installing Miniconda..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
sudo chmod +x Miniconda3-latest-Linux-x86_64.sh
./Miniconda3-latest-Linux-x86_64.sh



# Configure Rofi themes
echo "Configuring Rofi themes..."
cd ~
git clone https://github.com/lr-tech/rofi-themes-collection.git
cd rofi-themes-collection
mkdir -p ~/.local/share/rofi/themes/
cp themes/spotlight-dark.rasi ~/.local/share/rofi/themes/

# Configuring Docker
echo "Installing Docker..."
# sudo pacman -U ./docker-desktop-<version>-<arch>.pkg.tar.zst
sudo pacman -S docker
sudo systemctl enable docker.service
sudo systemctl start docker.service

# NeoVIM
echo "Installing Utilities..."
yay -S xprl thunderbird-beta-bin obsidian
sudo -v ; curl https://rclone.org/install.sh | sudo bash
mkdir /home/$USER/Documents/GDrive
rclone config
rclone mount --daemon gdrive: /home/$USER/Documents/GDrive 

# Additional packages (optional)
# Uncomment and modify as needed
# echo "Installing additional packages..."
# sudo pacman -S --noconfirm pulseaudio-alsa pulseaudio-bluetooth pulseaudio-equalizer pulseaudio-jack alsa-utils playerctl
cd
git clone https://github.com/rayanramoul/RayTerm/tree/master ~/.config/nvim
cd ~/.config/nvim
bash setup_all.sh
cd
echo "Setup completed! Please restart your system to apply changes."



