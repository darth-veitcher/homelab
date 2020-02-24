#!/bin/bash
# Frankenstein media lifecycle management
# module: Cache Sync
# author: Darth-Veitcher
#
# The purpose of this is to ensure that new files in the
# SSD hot-storage disk array are automatically syncd to 
# the `media` array (on spinning rust). As a result, any
# files that have been created more than X seconds ago
# are immediately incorporated into long-term, higher
# capacity storage. A separate function will delete and
# clear down the cache layer.
#
# Props to trapexit for their excellent work initially
# and on mergerfs.
# https://github.com/trapexit/mergerfs/blob/master/README.md#tiered-caching

if [ $# != 3 ]; then
  echo "usage: $0 <cache-drive> <backing-pool> <days-old>"
  exit 1
fi

echo "Started: $(date -u)"

CACHE="${1}"
BACKING="${2}"
N=${3}

# Create a lockfile
LOCK=/tmp/cache-sync.lock
if test -f "$LOCK"; then
    echo "$LOCK exists"
    exit 1
fi
touch $LOCK

# Find all files that are older than > N but aren't temporary rsync
# (starting with ".")
find "${CACHE}" -type f ! -iname ".*" -atime ${N} -printf '%P\n' | \
  rsync --files-from=- -axqHAXWES --preallocate "${CACHE}/" "${BACKING}/"

rm $LOCK
echo "Completed: $(date -u)"

# Delete rsync temporary files copied through with '.'
# find "${BACKING}" -type f -name '.*' -exec rm -rf {} \;