#!/bin/bash

# Check if an argument is provided
if [ $# -eq 0 ]; then
    echo "No arguments provided. Please specify 'arch', 'ubuntu', 'macos', or 'aws'."
    exit 1
fi

# Set the base directory where your Dockerfiles are located
BASE_DIR="docker"

# Function to build and run Docker image
build_and_run() {
    docker build --no-cache -f "$BASE_DIR/$1.Dockerfile" -t "dotfiles-$1" .
    docker run -it "dotfiles-$1"
}

# Case statement to handle different OS options
case $1 in
    arch)
        build_and_run "arch"
        ;;
    ubuntu)
        build_and_run "ubuntu"
        ;;
    osx)
        build_and_run "macos"
        ;;
    amazon)
        build_and_run "aws"
        ;;
    *)
        echo "Invalid argument. Please specify 'arch', 'ubuntu', 'macos', or 'aws'."
        exit 1
        ;;
esac

