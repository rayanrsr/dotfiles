# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git zsh tmux neovim

# Clone your dotfiles repository
RUN git clone https//github.com/rayanramoul/RayTerm/ ~/.config/nvim
# Set up your environment
RUN cd ~/.config/nvim
RUN bash setup_all.sh

# Set the default command to zsh
CMD ["zsh"]

