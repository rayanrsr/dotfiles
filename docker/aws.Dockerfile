# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git

WORKDIR /root
WORKDIR /root
RUN git clone https://github.com/rayanramoul/RayTerm/ ~/.config/nvim

# Set the working directory to where your dotfiles are
WORKDIR /root/.config/nvim 
RUN git clone https://github.com/rayanramoul/RayTerm/ ~/.config/nvim

# Set the working directory to where your dotfiles are
WORKDIR /root/.config/nvim 
# Clone your dotfiles repository
RUN bash setup_all.sh

# Set the default command to zsh
CMD ["zsh"]

