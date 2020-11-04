#!/bin/bash

VOLUME=`pwd`
echo ${STATUS}
echo "This USB stick has been identified as ${VOLUME}."
echo ""

echo "HOME is ${HOME}"

# check that a destination folder exists at ~/DG-MASTER
[ ! -d "${HOME}/DG-MASTER" ] && echo "Error: This process requires a destination directory at '${HOME}/DG-MASTER' BEFORE you begin!" && exit ${ERRCODE}

# make a ./logs directory if one does not exist
mkdir -p ${HOME}/DG-MASTER/logs

# current date and time to be used in filename
CDT=`date +%d-%b-%Y-%H-%M`
#echo ${CDT}

# source of this clone
SRC=$(find . -type f -name *DG-* | cut -f2 -d'/' | cut -f1 -d'.')
#echo ${SRC}

# log file name
LOG=rsync-to-MASTER_from_${SRC}_${CDT}.log
echo ".log file is: ${LOG}"

echo "Starting rsync now..."
rsync -azrui \
  --exclude ".DS_Store" \
  --exclude ".SpotlightV-100" \
  --exclude ".Trashes" \
  --exclude ".TemporaryItems" \
  --exclude ".git" \
  ${VOLUME}/. ~/DG-MASTER/. \
  --progress \
  --log-file=${HOME}/DG-MASTER/logs/${LOG}
echo "rsync is complete!"

echo ""
echo "Done!"
