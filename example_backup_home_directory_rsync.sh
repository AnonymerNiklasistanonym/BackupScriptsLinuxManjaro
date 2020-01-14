#!/usr/bin/env bash

mkdir -p backup_test
touch backup_test/file.txt
mkdir -p backup_test/dir
touch backup_test/file_2.txt

./backup_home_directory_rsync.sh backup_rsync backup_test
ls -lrt backup_rsync

mkdir -p backup_rsync/altered_in_rsync
touch backup_rsync/altered_in_rsync/file.txt
ls -lrt backup_rsync

./backup_home_directory_rsync.sh backup_rsync backup_test
ls -lrt backup_rsync

rm -rf backup_test
rm -rf backup_rsync

# Is there a solution
