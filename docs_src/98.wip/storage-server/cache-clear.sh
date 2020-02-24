#!/bin/bash
# Frankenstein media lifecycle management
# module: Cache Clear
# author: Darth-Veitcher
#
# The purpose of this is to ensure that the cache tier
# does not fill up. A separate function handles the sync
# and replication of data into the backing tier.
#
# Props to trapexit for their excellent work initially
# and on mergerfs.
# https://github.com/trapexit/mergerfs/blob/master/README.md#tiered-caching

if [ $# != 3 ]; then
  echo "usage: $0 <cache-drive> <backing-pool> <percentage>"
  exit 1
fi

CACHE="${1}"
BACKING="${2}"
PERCENTAGE=${3}

# Create a lockfile
LOCK=/tmp/cache-clear.lock
if test -f "$LOCK"; then
    echo "$LOCK exists"
    exit 1
fi
touch $LOCK

echo "Started: $(date -u)"

set -o errexit
while [ $(df --output=pcent "${CACHE}" | grep -v Use | cut -d'%' -f1) -gt ${PERCENTAGE} ]
do
    FILE=$(find "${CACHE}" -type f -printf '%A@ %P\n' | \
                  sort | \
                  head -n 1 | \
                  cut -d' ' -f2-)
    test -n "${FILE}"
    rsync -axqHAXWES --preallocate --remove-source-files "${CACHE}/./${FILE}" "${BACKING}/"
done

rm $LOCK
echo "Completed: $(date -u)"