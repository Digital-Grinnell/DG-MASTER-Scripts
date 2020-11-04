#!/bin/bash
# This script will rsync the entire contents of /Volumes/DG-MASTER to //STORAGE/Library/mcfatem/DG-MASTER

ERROR="\\033[31m"
GOOD="\\033[32m"
ATTENTION="\\033[35m"
NORMAL="\\033[36m"
STATUS="\\033[33m"
BOLD="\\033[1m"
echo "\\033[40m"

VOLUME=`pwd`
echo ${STATUS}
echo "This USB stick has been identified as ${VOLUME}."
echo ""

DEST=/Volumes/mcfatem/DG-MASTER
# DEST=/Volumes/mediadb/DG-MASTER    # alternate destination in the //STORAGE/MediaDB directory
echo "Destination is ${DEST}"

# check that destination folder ${DEST} has been mounted as /Volumes/mcfatem/DG-MASTER
[ ! -d ${DEST} ] && echo "Error: This process requires a destination directory mounted as '${DEST}' BEFORE you begin!" && exit ${ERRCODE}

# make a ./logs directory if one does not exist
mkdir -p ${DEST}/logs

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# source of this clone
SRC=$(find . -type f -name *DG-* | cut -f2 -d'/' | cut -f1 -d'.')
#echo ${SRC}

# log file name
LOG=rsync-to-STORAGE_from_${SRC}_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".Spotlight-V100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  ${VOLUME}/. ${DEST}/. \
  --progress \
  --log-file=${DEST}/logs/${LOG}
echo "rsync is complete!"

echo ""
echo "Done!"
