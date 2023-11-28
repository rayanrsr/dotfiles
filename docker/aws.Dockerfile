# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git zsh tmux neovim

# Clone your dotfiles repository
RUN git clone https://github.com/rayanramoul/RayTerm/ ~/dotfiles

# Set up your environment
RUN cd ~/dotfiles 
RUN bash setup_all.sh

# Set the default command to zsh
CMD ["zsh"]

