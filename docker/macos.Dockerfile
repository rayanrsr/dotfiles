# Use an Ubuntu image as the base
FROM sickcodes/docker-osx:latest

# Install Homebrew (Linuxbrew) for a macOS-like experience
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/Linuxbrew/install/master/install.sh)"



# Create a directory to clone the repository
WORKDIR ~/ 

# Run setup scripts from the dotfiles repositor

RUN sh -c "$(wget https://raw.githubusercontent.com/rayanramoul/RayTerm/master/install.sh -O -)"


# Set the default command to zsh
CMD ["zsh"]

