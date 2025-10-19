# Use the base Arch Linux image
FROM archlinux:latest

# Install necessary tools
RUN pacman -Syu --noconfirm && pacman -S --noconfirm git 


CMD ["bash"]

