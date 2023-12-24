# Use the latest Ubuntu image as the base
FROM ubuntu:20.04

# Install necessary tools
#RUN apt-get update -y #&& apt-get install -y git zsh tmux neovim
RUN apt-get update -y
RUN apt-get install -y wget git sudo
# Create a directory to clone the repository
WORKDIR ~

# Run setup scripts from the dotfiles repository
RUN wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh 
RUN bash install.sh
# Set the default command to zsh
CMD ["bash"]

