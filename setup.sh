#! /bin/bash

# create symlinks in .config to these dir
dirs_tolink=( sway waybar swaync alacritty )

repo_dir=$(dirname $(realpath "$0"))
target_dir=$HOME/.config

echo "src: $repo_dir"
echo "dst: $target_dir"

if [ ! -d "$target_dir" ]; then
    echo "create $target_dir"
    mkdir -p $target_dir
fi

for dir in "${dirs_tolink[@]}"; do
    src=$repo_dir/$dir
    dst=$target_dir/$dir

    if [ ! -d "$dst" ]; then
        echo "link $dst"
        ln -s $src $dst
    else
        echo "$dst exists, skip!"
    fi
done
