# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git


# Set the working directory to where your dotfiles are 
WORKDIR ~/

# Clone your dotfiles repository
RUN sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"
# Set the default command to zsh
CMD ["zsh"]

