# Use an Ubuntu image as the base
FROM ubuntu:latest

# Install Homebrew (Linuxbrew) for a macOS-like experience
RUN apt-get update && apt-get install -y build-essential curl file git
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"

# Add brew to PATH
ENV PATH="/home/linuxbrew/.linuxbrew/bin:${PATH}"

# Install necessary tools through Homebrew
RUN brew install git 

# Create a directory to clone the repository
WORKDIR /root
RUN git clone https://github.com/rayanramoul/RayTerm/ ~/.config/nvim 

# Set the working directory to where your dotfiles are
WORKDIR /root/.config/nvim

# Run setup scripts from the dotfiles repository
RUN bash setup_all.sh 

# Set the default command to zsh
CMD ["zsh"]

