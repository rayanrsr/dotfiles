# Use an Ubuntu image as the base
FROM sickcodes/docker-osx:latest

# Install Homebrew (Linuxbrew) for a macOS-like experience
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"



# Create a directory to clone the repository
WORKDIR ~/ 
RUN git clone https://github.com/rayanramoul/RayTerm/ ~/.config/nvim 

# Set the working directory to where your dotfiles are
WORKDIR ~/.config/nvim

# Run setup scripts from the dotfiles repositor
RUN pwd
RUN bash setup_all.sh 

# Set the default command to zsh
CMD ["zsh"]

