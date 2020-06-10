#!/usr/bin/env bash


VERSION=0.0.1
DEFAULT_BACKUP_DIR=/home/$USER/backup_home_directory/
DEFAULT_HOME_DIR=/home/$USER/


case "$1" in
  --help)
      echo "$(basename "$0") [BACKUP_DIR] [HOME_DIR]"
      echo ""
      echo "Create a backup of the home directory in another directory."
      echo ""
      echo "All arguments are optional, the default values are:"
      echo "    BACKUP_DIR = '$DEFAULT_BACKUP_DIR'"
      echo "    HOME_DIR   = '$DEFAULT_HOME_DIR'"
      echo "Options:"
      echo "    --help     Get usage info"
      echo "    --version  Get version info"
      exit 0
      ;;
  --version) # Version info
      echo "$VERSION"
      exit 0
      ;;
  *) # Other argument
      ;;
esac

# Check if there is a backup directory
if [ -n "$1" ]; then
  BACKUP_DIR=$1
else
  BACKUP_DIR=$DEFAULT_BACKUP_DIR
fi

# Check if there is a custom home directory
if [ -n "$2" ]; then
  HOME_DIR=$2
else
  HOME_DIR=$DEFAULT_HOME_DIR
fi

# Check if the backup directory is a directory
mkdir -p "$BACKUP_DIR"
if [ ! -d "$BACKUP_DIR" ]; then
  echo "Error: The backup directory '$BACKUP_DIR' does not exist!"
  exit 1
fi

# Check if the home directory is a directory
if [ ! -d "$HOME_DIR" ]; then
  echo "Error: The home directory '$HOME_DIR' does not exist!"
  exit 1
fi

echo "Backup '$HOME_DIR' to '$BACKUP_DIR'..."

set -x

# Option: "-v"/"--verbose"    to get a visual progress bar
# Option: "-r"/"--recursive"  to recurse into directories
# Option: "-a"/"--archive"    to preserve the date, ownership, permissions, groups
# Option: "--delete"          to delete deleted files in destination directory
# Option: "--delete-excluded" to also delete excluded files in destination directory
# Option: "--filter=':- .gitignore'" to use the gitignore files when doing a backup
# Option: "--exclude-from 'rsync_exclude_list.txt'" to ignore certain files from getting a backup
rsync -r -a -v                                \
      --delete                                \
      --exclude-from='rsync_exclude_list.txt' \
      --delete-excluded                       \
      "$HOME_DIR" "$BACKUP_DIR"

{ set +x; } 2>/dev/null
