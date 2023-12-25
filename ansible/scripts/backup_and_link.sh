#!/bin/bash

# Set the base directory
#base_dir="$(dirname "$(readlink -f "$0")")"
base_dir="$(pwd)"
# if ansible in directory name then go to parent directory
if [[ $base_dir == *"ansible"* ]]; then
    base_dir="$(dirname "$base_dir")"
fi
# if ansible and scripts in directory name then go to grand parent directory
if [[ $base_dir == *"ansible"* ]] && [[ $base_dir == *"scripts"* ]]; then
    base_dir="$(dirname "$(dirname "$base_dir")")"
fi
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
# Now loop through directories in dotfiles directory
for dir in "$base_dir/dotfiles"/*; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        target_dir="$HOME/$dirname"
        backup_and_link "$dir" "$target_dir"
    fi
done

# loop through directories and hidden directories in dotfiles directory like .oh-my-zsh
for dir in "$base_dir/dotfiles"/.[^.]*; do
    if [ -d "$dir" ]; then
        dirname=$(basename "$dir")
        target_dir="$HOME/$dirname"
        backup_and_link "$dir" "$target_dir"
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

