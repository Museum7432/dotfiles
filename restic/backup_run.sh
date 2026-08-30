#!/bin/bash
# backup user files with restic, should be put in local bin

if pgrep -f 'restic' > /dev/null; then
  echo 'restic is already running...' 1>&2
  exit 0
fi


set -e

XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-"$HOME/.config"}
XDG_CACHE_HOME=${XDG_CACHE_HOME:-"$HOME/.cache"}

RESTIC_CONFIG_HOME=$XDG_CONFIG_HOME/restic

RESTIC_INCLUDE_FILE=$RESTIC_CONFIG_HOME/restic_include
RESTIC_EXCLUDE_FILE=$RESTIC_CONFIG_HOME/restic_exclude
RESTIC_ENV_FILE=$RESTIC_CONFIG_HOME/.env

export RESTIC_CACHE_DIR=$XDG_CACHE_HOME/restic
mkdir -p "${RESTIC_CACHE_DIR}"


if [ ! -f "$RESTIC_ENV_FILE" ]; then
    echo "$RESTIC_ENV_FILE does not exist"
    exit 1
fi

# load the credentials
source "$RESTIC_ENV_FILE"

# check for changes and then prompt if user want to continue

restic backup -n -vv --files-from $RESTIC_INCLUDE_FILE --exclude-file $RESTIC_EXCLUDE_FILE | grep -v "unchanged "


read -r -p "Perform backup? [Y/n]" response
response=${response,,} # tolower
if [[ $response =~ ^(y| ) ]] || [[ -z $response ]]; then

  # backup the firefox profile dir
  FF_backup_file=~/Others/Backups/firefox_profile.tar.gz

  if [ -e $FF_backup_file ]; then
    echo remove old $FF_backup_file
    rm -- $FF_backup_file
  fi

  tar czf $FF_backup_file ~/.config/mozilla/firefox/*.*
  #



  # -n --no-lock -vv
  restic backup --files-from $RESTIC_INCLUDE_FILE --exclude-file $RESTIC_EXCLUDE_FILE --skip-if-unchanged --tag scripted
  restic forget --prune --keep-hourly 24 --keep-daily 30 --keep-monthly 6 --keep-weekly 4 --keep-yearly 3

fi




