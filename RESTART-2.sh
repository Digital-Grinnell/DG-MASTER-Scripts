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

echo ${ATTENTION}
echo "The script will begin a loop for up to 60 minutes. After each minute it will execute a 'docker logs -tail 20 isle-apache-ld' command to report progress and check the log output for 'Done setting proper permissions on files and directories'. Once that string appears the loop will be terminated automatically. ${NORMAL}"


for iteration in {1..60}
do
  echo ${STATUS}
  echo "Iteration ${iteration}. ${NORMAL}"
  if ( docker logs --tail 10 isle-apache-ld | grep -Fq "Done setting proper permissions on files and directories" ); then
    echo ${GOOD}
    echo "Process appears to be complete! Please move on to RESTART-3.sh now. ${NORMAL}"
    exit
  else
    sleep 60
  fi
done

echo ${ERROR}
echo "60 interations have run without the desired outcome so we will assume something has gone wrong.  Please report this condition to digital@grinnell.edu immediately. This process will be automatically terminated in 10 seconds."
sleep 10
exit
