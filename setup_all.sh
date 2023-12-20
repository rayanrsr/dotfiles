#/bin/bash
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


#!/bin/bash

# Function to install Ansible on Debian-based systems (e.g., Ubuntu)
install_ansible_debian() {
    sudo apt update
    sudo apt install -y ansible
}

# Function to install Ansible on Red Hat-based systems (e.g., Amazon Linux)
install_ansible_redhat() {
    sudo yum install -y ansible
}

# Function to install Ansible on Arch Linux
install_ansible_arch() {
    sudo pacman -Sy --noconfirm ansible
}

# Function to install Ansible on macOS using Homebrew
install_ansible_macos() {
    brew install ansible
}

# Determine the OS
OS=$(uname)

# Install Ansible based on the detected OS
case "$OS" in
    Linux*)
        if [ -f /etc/os-release ]; then
            source /etc/os-release
            case "$ID" in
                debian|ubuntu)
                    install_ansible_debian
                    ;;
                centos|rhel|fedora|amazon)
                    install_ansible_redhat
                    ;;
                arch)
                    install_ansible_arch
                    ;;
                *)
                    echo "Unsupported Linux distribution: $ID"
                    exit 1
                    ;;
            esac
        else
            echo "Unable to determine Linux distribution."
            exit 1
        fi
        ;;
    Darwin*)
        install_ansible_macos
        ;;
    *)
        echo "Unsupported operating system: $OS"
        exit 1
        ;;
esac

# Execute the Ansible playbook
ansible-playbook -i localhost, setup_terminal.yml


#bash setup_terminal.sh
#bash setup_lsps.sh
#bash setup_tmux.sh
bash setup_dotfiles.sh
