#!/bin/bash

# Set the base directory
base_dir="$(dirname "$(readlink -f "$0")")"

# Function to backup existing file or directory
backup_and_link() {
    local source_path=$1
    local target_path=$2

    # Backup existing file or directory
    if [ -e "$target_path" ]; then
        echo "Backing up existing $target_path"
        mv "$target_path" "$target_path.bak"
    fi

    # Create symbolic link
    ln -s "$source_path" "$target_path"
    echo "Linked $source_path to $target_path"
}

# Loop through files in dotfiles directory
for file in "$base_dir/dotfiles"/* "$base_dir/dotfiles"/.[^.]*; do
    if [ -f "$file" ]; then
        filename=$(basename "$file")
        target_file="$HOME/$filename"
        backup_and_link "$file" "$target_file"
    fi
done

# Loop through directories in .config directory inside dotfiles
config_dir="$base_dir/dotfiles/.config"
for dir in "$config_dir"/*; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        target_dir="$HOME/.config/$dirname"
        backup_and_link "$dir" "$target_dir"
    fi
done

echo "Dotfiles setup completed successfully!"

