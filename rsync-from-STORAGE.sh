#!/bin/bash
# This script will rsync the DATA contents of //STORAGE/Library/mcfatem/DG-MASTER to your mounted /Volumes/DG-NAME USB stick.
# It will NOT update the scripts, only the DATA and the .git structure that can be used to update the scripts.
#
# To update the scripts use:
#
#    cd /Volumes/DG-NAME
#    git pull origin master

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

SRC=/Volumes/mcfatem/DG-MASTER
# SRC=/Volumes/mediadb/DG-MASTER    # alternate source as //STORAGE/MediaDB directory
echo "Source is ${SRC}"

# check that source folder ${SRC} has been mounted as /Volumes/mcfatem/DG-MASTER
[ ! -d ${SRC} ] && echo "Error: This process requires a source directory mounted as '${SRC}' BEFORE you begin!" && exit ${ERRCODE}

# make a ./logs directory if one does not exist
mkdir -p ${DEST}/logs

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# destination of this rsync
DEST=$(find . -type f -name *DG-* | cut -f2 -d'/' | cut -f1 -d'.')
#echo ${DEST}

# log file name
LOG=rsync-from-STORAGE_to_${DEST}_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".Spotlight-V100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  --exclude "*.sh" \
  --exclude "*.md" \
  ${SRC}/. . \
  --progress \
  --log-file=./logs/${LOG}
echo "rsync is complete!"

echo ""
echo "Done!"
