base_dir=$(dirname $0)
# if we're inside ansible dir, go up one level
if [ $(basename $base_dir) == "ansible" ]; then
    base_dir=$(dirname $base_dir)
fi
# if we're inside scripts dir, go up 2 levels
if [ $(basename $base_dir) == "scripts" ]; then
    base_dir=$(dirname $base_dir)
    base_dir=$(dirname $base_dir)
fi
stow -t $HOME -R $base_dir
