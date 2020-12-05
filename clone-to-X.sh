#!/bin/bash

VOLUME=`pwd`
echo ${STATUS}
echo "This USB stick has been identified as ${VOLUME}."
echo ""
SRC=${VOLUME}

# check that a volume (USB stick or other) is mounted as /Volumes/DG-CLONE
[ ! -d "/Volumes/DG-CLONE" ] && echo "Error: You must mount a volume at '/Volumes/DG-CLONE' BEFORE you begin!" && exit ${ERRCODE}

# make sure DG-CLONE is writable
sudo mount -u -w /Volumes/DG-CLONE

# make a ./logs directory if one does not exist
mkdir -p /Volumes/DG-CLONE/logs

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# log file name
LOG=clone-to-X_from_${SRC}_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".fseventsd" \
  ${VOLUME}/. /Volumes/DG-CLONE/. \
  --progress \
  --log-file=/Volumes/DG-CLONE/logs/${LOG}
echo "rsync is complete!"

echo ""
echo "You should now take steps to rename the DG-CLONE USB stick. Give it a new, UNIQUE 'DG-' name specific to you or to its intended use, like 'DG-MARK1' or 'DG-EMBARK'."
echo ""
echo "Also, there should be one .md file named the same as the volume, so if the volume name becomes 'DG-MARK1', for example, you shold also create or rename a similar file to be 'DG-MARK1.md' with contents like this:"
echo ""
echo "This USB stick, DG-MARK1, was created by cloning DG-FEDORA-0 on 10-26-2020.  It is intended for use ONLY on Mark's PERSONAL MacBook Air."
