#!/bin/bash

# Determine OS
OS="$(uname)"
echo "Detected OS: $OS"

# Installation for Arch Linux
if [ "$OS" = "Linux" ]; then
  echo "Assuming Arch Linux or derivatives..."
  # Install npm if not installed
  if ! command -v npm &> /dev/null; then
      sudo pacman -Sy npm --noconfirm
  fi

  # Install language servers
  sudo npm i -g vscode-langservers-extracted
  sudo npm install -g typescript typescript-language-server
  sudo npm i -g pyright

  # Install other LSPs and tools via pacman or yay
  sudo pacman -S lua-language-server --noconfirm
  sudo pacman -S rustup --noconfirm
  rustup default stable
  rustup component add rust-src
  sudo pacman -S ripgrep fd --noconfirm

  # Check for yay and install anakin-language-server
  if command -v yay &> /dev/null; then
      yay -S anakin-language-server --noconfirm
  else
      echo "yay not found. You may need to install anakin-language-server manually."
  fi

# Installation for macOS
elif [ "$OS" = "Darwin" ]; then
  echo "Installing on macOS..."
  # Check if Homebrew is installed
  if ! command -v brew &> /dev/null; then
      echo "Homebrew not found. Please install it first."
      exit 1
  fi

  # Install npm and pip packages using Homebrew
  brew install npm
  npm i -g vscode-langservers-extracted
  npm install -g typescript typescript-language-server
  npm i -g pyright

  # Install ripgrep and fd using Homebrew
  brew install ripgrep fd

  # Install language servers using Homebrew or pip
  # Lua language server (assuming Lua is installed)
  brew install lua-language-server

  # Rust tools
  brew install rustup
  rustup-init -y --default-toolchain stable
  rustup component add rust-src

  # Python LSP
  pip3 install 'python-language-server[all]'

else
  echo "Unsupported OS."
  exit 1
fi

echo "LSP installation script completed."

