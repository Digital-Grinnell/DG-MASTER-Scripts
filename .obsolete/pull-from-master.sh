#!/bin/bash

# pull-from-master.sh
# This script is maintained as a public gist to simplify sharing.
# It can be found at https://gist.github.com/Digital-Grinnell/69c3cca524071098bbf5c865ec632164.

VOLUME=`pwd`
echo "This USB stick has been identified as ${VOLUME}."
echo ""

# check that //STORAGE/LIBRARY/mcfatem/DG-FEDORA-Master is mounted
[ ! -d "/Volumes/mcfatem/DG-FEDORA-Master" ] && echo "Error: You must mount 'smb://Storage/Library/mcfatem' in Finder BEFORE you begin!" && exit ${ERRCODE}

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# source of this pull-from-master
SRC="DG-FEDORA-Master"
#echo ${SRC}

# log file name
LOG=pull-from_DG-FEDORA-Master_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".SpotlightV-100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  --exclude ".git" \
  /Volumes/mcfatem/DG-FEDORA-Master/. ${VOLUME}/. \
  --progress \
  --log-file=${LOG}
echo "rsync is complete!"
