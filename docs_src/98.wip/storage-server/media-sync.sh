#!/bin/bash
# Frankenstein media lifecycle management
# module: Media Sync
# author: Darth-Veitcher
#
# The purpose of this is to rsync:// file from media on
# feederbox to local unionfs (which uses the SSD cache)

if [ $# != 2 ]; then
  echo "usage: $0 <remote> <localPath>"
  exit 1
fi

echo "Started: $(date -u)"

REMOTE="${1}"
LOCAL="${2}"

# Create a lockfile
LOCK=/tmp/media-sync.lock
if test -f "$LOCK"; then
    echo "$LOCK exists"
    exit 1
fi
touch $LOCK

rsync -rLvP "${REMOTE}" "${LOCAL}"

rm $LOCK
echo "Completed: $(date -u)"