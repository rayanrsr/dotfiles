#!/bin/bash

# Determine OS
OS="$(uname)"
echo "Detected OS: $OS"

# Function to get the Python command
get_python_cmd() {
  if command -v python3 &>/dev/null; then
    echo "python3"
  else
    echo "python"
  fi
}

# Installation and configuration steps that are common between Arch Linux and macOS
install_common_packages() {
  echo "Installing Oh-My-Zsh..."
  sh -c "$(wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

  echo "Downloading and installing Meslo Nerd Font..."
  FONT_PATH="$HOME/.local/share/fonts"
  FONT_NAME="MesloLGS NF Regular.ttf"
  FONT_URL="https://github.com/romkatv/dotfiles-public/raw/master/.local/share/fonts/NerdFonts/${FONT_NAME// /%20}"
  mkdir -p "${FONT_PATH}"
  wget -O "${FONT_PATH}/${FONT_NAME}" "${FONT_URL}"

  echo "Installing additional fonts from 'fonts' folder..."
  cp -r fonts/* "${FONT_PATH}/"

  echo "Generating an SSH key..."
  ssh-keygen -t rsa -b 4096 # specifying the type and bit length for the key

  echo "Configuring Zsh plugins..."
  ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}
  git clone --depth 1 https://github.com/marlonrichert/zsh-autocomplete.git "${ZSH_CUSTOM}/plugins/zsh-autocomplete"
  git clone https://github.com/zsh-users/zsh-autosuggestions "${ZSH_CUSTOM}/plugins/zsh-autosuggestions"
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git "${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "${ZSH_CUSTOM}/themes/powerlevel10k"

  echo "Downloading .zshrc and .p10k.zsh..."
  # Remove existing config files if they exist
  rm -f ~/.zshrc ~/.p10k.zsh
  wget -O ~/.zshrc https://raw.githubusercontent.com/rayanramoul/BetterLinux/master/dotfiles/.zshrc
  wget -O ~/.p10k.zsh https://raw.githubusercontent.com/rayanramoul/BetterLinux/master/dotfiles/.p10k.zsh

  echo "Installing Miniconda..."
  wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
  sudo chmod +x Miniconda3-latest-Linux-x86_64.sh
  ./Miniconda3-latest-Linux-x86_64.sh

  echo "Installing tmux..."
  if [ "$OS" = "Linux" ]; then
    sudo pacman -S --noconfirm tmux
  elif [ "$OS" = "Darwin" ]; then
    brew install tmux
  fi
  echo "Default keybindings for tmux: 'Ctrl-b' as the prefix key. For example, 'Ctrl-b c' to create a new window."

  echo "Installing fzf..."
  if [ "$OS" = "Linux" ]; then
    sudo pacman -S --noconfirm fzf
  elif [ "$OS" = "Darwin" ]; then
    brew install fzf
  fi
  echo "Default keybindings for fzf: 'Ctrl-r' for command history search and 'Ctrl-t' for file search."

  echo "Installing Alacritty..."
  if [ "$OS" = "Linux" ]; then
    sudo pacman -S --noconfirm alacritty
  elif [ "$OS" = "Darwin" ]; then
    brew install --cask alacritty
  fi
  echo "Alacritty installed. Configuring..."
  mkdir -p ~/.config/alacritty
  cp .alacritty/* ~/.config/alacritty/
}

# Install packages depending on OS
if [ "$OS" = "Linux" ]; then
  echo "Running setup for Arch Linux..."
  # Install packages using pacman and yay
  sudo pacman -Sy --noconfirm neovim alacritty zsh
  yay -S --noconfirm neovim alacritty zsh
  install_common_packages

elif [ "$OS" = "Darwin" ]; then
  echo "Running setup for macOS..."
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Installing Homebrew first..."
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi

  # Install packages using Homebrew
  brew install neovim zsh
  brew install --cask alacritty

  install_common_packages
else
  echo "Unsupported OS."
  exit 1
fi

# Change the default shell to Zsh
echo "Changing the default shell to Zsh..."
chsh -s "$(which zsh)"

echo "Use the Obsidian theme for your terminal emulator of choice!"

# Final message
echo "Setup complete! Please restart your terminal for all changes to take effect."

echo "Installing debugpy in a dedicated virtualenv..."
mkdir -p "$HOME/.virtualenvs"
cd "$HOME/.virtualenvs"
PYTHON_CMD=$(get_python_cmd)
$PYTHON_CMD -m venv debugpy
$HOME/.virtualenvs/debugpy/bin/python -m pip install debugpy
cd - # Go back to the previous directory
