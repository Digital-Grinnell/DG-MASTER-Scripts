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

UP=`docker ps -a | grep -c -F "Up "`

if [ ${UP} -lt "7" ]; then
  echo ${ERROR}
  echo "There are ${UP} running containers but should be at least SEVEN. Please contact digital@grinnell.edu to report this error.  This process will be terminated in 20 seconds. ${NORMAL}"
  sleep 20
  exit
else
  echo ${GOOD}
  echo "There are at least SEVEN running containers.  Moving on...${NORMAL}"
  echo ""
fi

echo ${STATUS}
echo "Copying a previously captured Drupal site database to your MySQL container... ${NORMAL}"
docker cp ${VOLUME}/Extras/prod-export.sql  isle-mysql-ld:/prod-export.sql
echo ${GOOD}
echo "Copy is complete.  Moving on... ${NORMAL}"
echo ""

echo ${ATTENTION}
echo "The next command will open a terminal inside your running MySQL container. Copy and paste the following into that terminal prompt: ${NORMAL}"
echo "  mysql -u root -p digital_grinnell < prod-export.sql; mysql -u root -p digital_grinnell -e 'show tables;'; exit; "
echo ""
echo ${ATTENTION}
echo "When prompted for a password, be sure to use the dg.localdomain MySQL password found in LastPass. Ultimately you should see a long list of table names dumped from your database. The list should end with 'xmlsitemap_sitemap'. "
echo ${NORMAL}
docker exec -it isle-mysql-ld bash
echo ""

echo ${STATUS}
echo "Updating the IMI module using 'composer update'.  Please be patient, this could take a few minutes... ${NORMAL}"
docker exec -w /var/www/html/sites/all/modules/islandora/islandora_multi_importer/ isle-apache-ld composer update

echo ${ATTENTION}
echo "When the next command runs you should eventually see a completion message indicating:"
echo ${BOLD}
echo "  SUCCESS: 129 objects rebuilt.  "
echo ${ATTENTION}
echo "Once you see the above message appear TWICE, press CTRL+C to terminate the session, then move on to RESTART-4. ${NORMAL}"

sleep 20  # time for reading

echo ${STATUS}
echo "Starting to rebuild the FEDORA resource index. Please be patient, this could take a few minutes... ${NORMAL}"
docker exec -w /utility_scripts isle-fedora-ld ./rebuildFedora.sh

echo ${GOOD}
echo "RESTART-3 is finished. Please move on to RESTART-4 now."
