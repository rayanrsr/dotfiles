#!/bin/bash

# Determine OS
OS="$(uname)"
echo "Detected OS: $OS"

install_npm_packages() {
    npm i -g vscode-langservers-extracted
    npm install -g typescript typescript-language-server
    npm i -g pyright
}

# Installation for Arch Linux
if [ "$OS" = "Linux" ] && [ -f /etc/arch-release ]; then
    echo "Assuming Arch Linux or derivatives..."
    # Install npm if not installed
    if ! command -v npm &> /dev/null; then
        pacman -Sy npm --noconfirm
    fi

    install_npm_packages

    # Install other LSPs and tools via pacman
    pacman -S lua-language-server rustup ruff-lsp ripgrep fd --noconfirm
    rustup default stable
    rustup component add rust-src

    # Check for yay and install anakin-language-server
    if command -v yay &> /dev/null; then
        yay -S anakin-language-server --noconfirm
    else
        echo "yay not found. You may need to install anakin-language-server manually."
    fi

# Installation for Ubuntu or Amazon EC2
elif [ "$OS" = "Linux" ]; then
    echo "Assuming Ubuntu or Amazon EC2 (Amazon Linux)..."
    # Determine package manager (apt for Ubuntu, yum for Amazon Linux)
    if command -v apt &> /dev/null; then
        PKG_MANAGER="apt"
        
    elif command -v yum &> /dev/null; then
        PKG_MANAGER="yum"
    else
        echo "Neither apt nor yum found. Exiting."
        exit 1
    fi

    # Install npm if not installed
    if ! command -v npm &> /dev/null; then
        echo "Installing npm and rustc..."
        $PKG_MANAGER install npm rustc -y
        curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh  -s -- -y 
    fi

    install_npm_packages

    # Install other LSPs and tools
    $PKG_MANAGER install ripgrep fd-find -y
    npm install -g ruff-lsp

    # Rust tools
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    rustup default stable
    rustup component add rust-src

    # Python LSP
    python3 -m pip install 'python-language-server[all]'
    python -m pip install 'python-language-server[all]'
# Installation for macOS
elif [ "$OS" = "Darwin" ]; then
    echo "Installing on macOS..."
    # Check if Homebrew is installed
    if ! command -v brew &> /dev/null; then
        echo "Homebrew not found. Please install it first."
        exit 1
    fi

    brew install npm
    install_npm_packages

    # Install ripgrep and fd using Homebrew
    brew install ripgrep fd

    # Lua language server
    brew install lua-language-server

    # Rust tools
    brew install rustup
    rustup-init -y --default-toolchain stable
    rustup component add rust-src

    # Python LSP
    python3 -m pip install 'python-language-server[all]'
    python -m pip install 'python-language-server[all]'
else
    echo "Unsupported OS."
    exit 1
fi

python3 -m pip install ruff-lsp
python -m pip install ruff-lsp
echo "LSP installation script completed."

