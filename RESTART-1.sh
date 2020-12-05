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
echo "The next command may prompt for a password. Enter your 'workstation' password, please. ${NORMAL}"
# Make a /tmp/safe-to-delete directory that can be used for FEDORA ActiveMQ crap
sudo mkdir -p /tmp/safe-to-delete
sudo chmod 777 /tmp/safe-to-delete
# Make sure our dg.localdomain networking is up-to-date in /etc/hosts
echo "127.0.0.1  localhost dg.localdomain admin.dg.localdomain portainer.dg.localdomain images.dg.localdomain" | sudo tee -a /etc/hosts

echo ${STATUS}
echo "Ensuring that ${VOLUME} is mounted for read/write access..."
sudo mount -u -w ${VOLUME}

echo ${STATUS}
echo "Resetting the local Docker environment... ${NORMAL}"
docker stop $(docker ps -q)
docker rm -v $(docker ps -qa)
docker image rm $(docker image ls -q) --force
docker system prune --force

echo ${STATUS}
echo "Creating the required workstation directory structure in your home directory... ${NORMAL}"
cd ~
rm -fr ISLE;
mkdir -p ISLE && cd $_
echo ${ATTENTION}
echo "If the next 'git...' commands prompt for a username and password, ask digital@grinnell.edu for necessary github/Digital-Grinnell credentials and enter those credentials when prompted below. ${NORMAL}"
git clone --recursive https://github.com/Digital-Grinnell/dg-isle
if [ $? -eq 0 ]; then
  echo ${GOOD}
  echo "The Digital-Grinnell/dg-isle repository has been successfully cloned. ${NORMAL}"
else
  echo ${ERROR}
  echo "ERROR: The Digital-Grinnell/dg-isle repository could not be cloned. See ${VOLUME}/reset-keychain-access.md for guidance and/or contact digital@grinnell.edu for necessary credentials."; exit $ERRORCODE;
fi

# change all /Volumes/DG-*/ paths in ~/ISLE/dg-isle/docker-compose.DG-LOCAL.yml to ${VOLUME}
echo ${STATUS}
echo "Using 'sed' to redirect /Volumes/DG-SOMETHING/ references to this USB stick... ${NORMAL}"
sed -i.backup "s|/Volumes/DG-[A-Z]*/|${VOLUME}/|" ~/ISLE/dg-isle/docker-compose.DG-LOCAL.yml

git clone --recursive https://github.com/Digital-Grinnell/dg-islandora
if [ $? -eq 0 ]; then
  echo ${GOOD}
  echo "The Digital-Grinnell/dg-islandora repository has been successfully cloned. ${NORMAL}"
else
  echo ${ERROR}
  echo "ERROR: The Digital-Grinnell/dg-islandora repository could not be cloned. See ${VOLUME}/reset-keychain-access.md for guidance and/or contact digital@grinnell.edu for necessary credentials."; exit $ERRORCODE;
fi

echo ${NORMAL}

cd dg-isle
cp DG-MASTER.env .env

echo ${STATUS}
echo "Pulling Docker images and starting 7 containers... ${NORMAL}"

docker-compose pull
docker-compose up -d

UP=`docker ps -a | grep -c -F 'Up '`

if [ "${UP}" -lt "7" ]; then
  echo ${ERROR}
  echo "There are ${UP} running containers but should be at least SEVEN. Please contact digital@grinnell.edu to report this error.  This process will be terminated in 20 seconds. ${NORMAL}"
  sleep 20
  exit
fi

echo ${GOOD}
echo "RESTART-1 is finished. Please move on to RESTART-2 now."
