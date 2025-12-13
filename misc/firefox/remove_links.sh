#! /bin/bash
# remove symlinks to user.js and chrome folder in .mozilla/firefox/*.*


profile_dirs=$(find ~/.mozilla/firefox/*.* -maxdepth 0 -type d)

for dir in $profile_dirs; do
    dest_userjs="$dir/user.js"
    dest_chrome="$dir/chrome"

    pname=${dir#*.*.}

    echo "$pname:"


    if [ -L "$dest_userjs" ]; then
        unlink $dest_userjs

        echo "  unlink user.js in $pname"
    fi

    # if [ -L "$dest_chrome" ]; then
    #     unlink $dest_chrome
    #     echo "  unlink chrome in $pname"
    # fi
done
