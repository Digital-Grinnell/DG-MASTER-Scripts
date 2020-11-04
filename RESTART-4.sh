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

echo ${STATUS}
echo "Starting a background rebuild of the Solr index in 10 seconds... ${NORMAL}"
sleep 10
docker exec -w /utility_scripts isle-fedora-ld ./updateSolrIndex.sh

echo ${STATUS}
echo "Starting the FINAL operation, flusing the Drupal caches... ${NORMAL}"
docker exec -w /var/www/html/sites/default isle-apache-ld drush cc all

echo ${GOOD}
echo "All done.  Try visiting https://dg.localdomain now."
