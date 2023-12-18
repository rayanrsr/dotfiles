rm -rf ~/.config-backup
cp -r ~/.config/ ~/.config-backup

# loop over all files and directories inside the dotfiles directory and ln -s them to the home directory
# so that dotfiles would be as a home directory

DOTFILES_DIR=$(pwd)/dotfiles
for file in $(ls -A $DOTFILES_DIR); do
    if [ $file != "setup_dotfiles.sh" ]; then
        ln -s $DOTFILES_DIR/$file ~/$file
    fi
done
