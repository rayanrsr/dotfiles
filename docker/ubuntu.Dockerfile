# Use the latest Ubuntu image as the base
FROM ubuntu:latest

# Install necessary tools
RUN apt-get update && apt-get install -y git zsh tmux neovim

# Create a directory to clone the repository
WORKDIR ~
RUN git clone https://github.com/rayanramoul/RayTerm/ 

# Run setup scripts from the dotfiles repository
WORKDIR ~/RayTerm
RUN bash setup_all.sh

# Set the default command to zsh
CMD ["zsh"]

