#! /bin/bash
# create symlinks to user.js and chrome folder in .mozilla/firefox/*.*
BASEDIR=$(dirname $(realpath "$0"))

profile_dirs=$(find ~/.mozilla/firefox/*.* -maxdepth 0 -type d)

source_userjs="$BASEDIR/user.js"
# source_chrome_dir="$BASEDIR/chrome"

for dir in $profile_dirs
do
    dest_userjs="$dir/user.js"
    # dest_chrome="$dir/chrome"

    echo "create link in ${dir#*.*.}"

    if [ -f "$dest_userjs" ]; then
        echo "  user.js existed"
    else
        ln -s $source_userjs $dest_userjs
    fi

    # if [ -d "$dest_chrome" ]; then
    #     echo "  chrome existed"
    # else
    #     ln -s $source_chrome_dir $dest_chrome
    # fi

done
