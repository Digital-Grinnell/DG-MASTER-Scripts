#!/bin/bash

VOLUME=`pwd`
echo "This USB stick has been identified as ${VOLUME}."
echo ""

# check that //STORAGE/LIBRARY/mcfatem/DG-FEDORA-Master is mounted
[ ! -d "/Volumes/mcfatem/DG-FEDORA-Master" ] && echo "Error: You must mount 'smb://Storage/Library/mcfatem' in Finder BEFORE you begin!" && exit ${ERRCODE}

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# source of this push-to-master
SRC=$(find . -type f -name *DG-* | cut -f2 -d'/' | cut -f1 -d'.')
#echo ${SRC}

# log file name
LOG=push-to-master_from_${SRC}_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".SpotlightV-100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  --exclude ".git" \
  --exclude "RESTART-1.sh" \
  --exclude "RESTART-2.sh" \
  --exclude "RESTART-3.sh" \
  --exclude "RESTART-4.sh" \
  --exclude "${SRC}.md" \
  ${VOLUME}/. /Volumes/mcfatem/DG-FEDORA-Master/. \
  --progress \
  --log-file=/Volumes/mcfatem/DG-FEDORA-Master/logs/${LOG}
echo "rsync is complete!"
