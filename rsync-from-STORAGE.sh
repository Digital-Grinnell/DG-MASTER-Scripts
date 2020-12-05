#!/bin/bash
# This script will rsync the DATA contents of //STORAGE/Library/mcfatem/DG-MASTER/Backup-Data to the Backup-Data folder in your mounted /Volumes/DG-NAME USB stick.
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
DEST=${VOLUME}

SRC=/Volumes/mcfatem/DG-MASTER/Backup-Data
echo "Source is ${SRC}"

# check that source folder ${SRC} has been mounted as /Volumes/mcfatem/DG-MASTER
[ ! -d ${SRC} ] && echo "Error: This process requires a source directory mounted as '${SRC}' BEFORE you begin!" && exit ${ERRCODE}

# make a ./logs directory if one does not exist
mkdir -p ${DEST}/logs

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# log file name
LOG=rsync-from-STORAGE_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".Spotlight-V100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  --exclude "coversheets*" \
  ${SRC}/. ${DEST}/Backup-Data/. \
  --progress \
  --log-file=./logs/${LOG}
echo "rsync is complete!"

echo ""
echo "Done!"
