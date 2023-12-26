# Use the latest Amazon Linux image as the base
FROM amazonlinux:latest

# Install necessary tools
RUN yum update -y && yum install -y git


# Set the working directory to where your dotfiles are 
CMD ["bash"]

