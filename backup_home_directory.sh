#!/usr/bin/env bash

BACKUP_DIR=$1
HOME_DIR=/home/$USER/

# -------TESTING-----------------
BACKUP_DIR=/home/$USER/backup_test/
#rm -rf "$BACKUP_DIR"
#mkdir -p "$BACKUP_DIR"
#HOME_DIR=/home/$USER/backup_test_original/
# -------TESTING-----------------

# Option: "-v"/"--verbose"   to get a visual progress bar
# Option: "-r"/"--recursive" to recurse into directories
# Option: "-a"/"--archive"   to preserve the date, ownership, permissions, groups
# Option: "--delete"         to delete deleted files in destination directory
# Option: "--filter=':- .gitignore'" to use the gitignore files when doing a backup
# Option: "--exclude-from 'rsync_exclude_list.txt'" to ignore certain files from getting a backup
rsync -r -a -v --delete --filter=':- .gitignore' --exclude-from 'rsync_exclude_list.txt' "$HOME_DIR" "$BACKUP_DIR"
