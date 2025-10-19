# Use the latest Ubuntu image as the base
FROM ubuntu:20.04

# Install necessary tools
#RUN apt-get update -y #&& apt-get install -y git zsh tmux neovim
RUN apt-get update -y
RUN apt-get install -y wget git sudo
# Create a directory to clone the repository
CMD ["bash"]

