# Use the base Arch Linux image
FROM archlinux:latest

# Install necessary tools
RUN pacman -Syu --noconfirm && pacman -S --noconfirm git 

# Create a directory to clone the repository
WORKDIR ~ 

# Run setup scripts from the dotfiles repository
RUN sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"
# Set the default command to zsh
CMD ["zsh"]

