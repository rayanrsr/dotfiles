# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git


# Set the working directory to where your dotfiles are 
WORKDIR ~/
RUN git clone https://github.com/rayanramoul/RayTerm/

# Set the working directory to where your dotfiles are
WORKDIR ~/RayTerm
# Clone your dotfiles repository
RUN bash setup_all.sh

# Set the default command to zsh
CMD ["zsh"]

