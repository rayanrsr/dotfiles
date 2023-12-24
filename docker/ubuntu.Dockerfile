# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y git zsh tmux neovim

# Create a directory to clone the repository
WORKDIR ~

# Run setup scripts from the dotfiles repository

RUN sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"
# Set the default command to zsh
CMD ["zsh"]

