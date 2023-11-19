# check if ./tmux/plugins/tmp exists
# if not, clone it
# copy tmux.conf to ~/.config/tmux/

if [ ! -d "./tmux/plugins/tpm" ]; then
    echo "Cloning tmux plugin manager"
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source tmux/tmux.conf
cp -r tmux/ ~/.config/tmux/

echo "Dont forget to install tmux plugin manager by running: "
echo "ctrl b I"
