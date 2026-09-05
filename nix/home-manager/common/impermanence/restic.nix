# this only backup the current user data
# will change if I ever use more than one user
{ config, lib, pkgs, ... }:
let
  run-restic = pkgs.writeShellScriptBin "run-restic" ''

    if pgrep -f 'restic' > /dev/null; then
    echo 'restic is already running...' 1>&2
    exit 0
    fi

    set -e

    RESTIC_INCLUDE_FILE=${config.xdg.configHome}/restic/restic_include
    RESTIC_EXCLUDE_FILE=${config.xdg.configHome}/restic/restic_exclude
    RESTIC_ENV_FILE=/persist/secrets/${config.home.username}/restic.env

    source $RESTIC_ENV_FILE

    # check for changes and then prompt if user want to continue
    restic backup -n -vv --files-from $RESTIC_INCLUDE_FILE --exclude-file $RESTIC_EXCLUDE_FILE | grep -v "unchanged "

    read -r -p "Perform backup? [y/n]" response
    response=''${response,,} # tolower
    if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then
        restic backup --files-from $RESTIC_INCLUDE_FILE --exclude-file $RESTIC_EXCLUDE_FILE --skip-if-unchanged --tag scripted
        restic forget --prune --keep-hourly 24 --keep-daily 30 --keep-monthly 6 --keep-weekly 4 --keep-yearly 3
    fi
  '';
in
{
  home.packages = [ run-restic pkgs.restic ];

  # backup the persist partition instead
  xdg.configFile."restic/restic_include".text = ''
    /persist/data/home/${config.home.username}/Documents
    /persist/data/home/${config.home.username}/Music
    /persist/data/home/${config.home.username}/Others
    /persist/data/home/${config.home.username}/Pictures
    /persist/data/home/${config.home.username}/Projects
    /persist/data/home/${config.home.username}/Videos
    /persist/data/home/${config.home.username}/Videos

    /persist/data/home/${config.home.username}/.ssh
    /persist/data/home/${config.home.username}/.gnupg

    /persist/firefox/home/${config.home.username}
    /persist/google-chrome/home/${config.home.username}

    /persist/gnome_keyring/home/${config.home.username}
  '';

  xdg.configFile."restic/restic_exclude".text = ''
    /lost+found/**
    /media/**
    /mnt/**
    /proc/**
    /root/**
    /run/**
    /swapfile
    /sys/**
    /tmp/**
    /var/cache/**
    /var/lib/docker/**
    /var/lib/libvirt/**
    /var/lock/**
    /var/log/**
    /var/run/**
    /data/**
    /dev/**
    /**/.mozilla/firefox/*/Cache/**
    /**/.git
    /**/__pycache__
    /**/.pixi
    /**/node_modules
    /**/.cache
    /**/.local
    /**/site-packages
    /**/.cargo
    /**/.ssh/agent
  '';

}
