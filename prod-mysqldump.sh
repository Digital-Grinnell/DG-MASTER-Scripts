# prod-mysqldump.sh
#
# From DGDocker1 shell into the isle-mysql-dg container and...
docker exec -it isle-mysql-dg #!/usr/bin/env bash
#
mysqldump -u root -p --no-data digital_grinnell > prod-export.sql
#
mysqldump -u root -p --no-create-info --ignore-table=digital_grinnell.accesslog \
  --ignore-table=digital_grinnell.batch --ignore-table=digital_grinnell.batch_log \
  --ignore-table=digital_grinnell.batch_log_revision --ignore-table=digital_grinnell.cache \
  --ignore-table=digital_grinnell.cache_admin_menu --ignore-table=digital_grinnell.cache_block \
  --ignore-table=digital_grinnell.cache_bootstrap --ignore-table=digital_grinnell.cache_field \
  --ignore-table=digital_grinnell.cache_filter --ignore-table=digital_grinnell.cache_form \
  --ignore-table=digital_grinnell.cache_image --ignore-table=digital_grinnell.cache_libraries \
  --ignore-table=digital_grinnell.cache_menu --ignore-table=digital_grinnell.cache_page \
  --ignore-table=digital_grinnell.cache_path --ignore-table=digital_grinnell.cache_rules \
  --ignore-table=digital_grinnell.cache_session_cache --ignore-table=digital_grinnell.cache_token \
  --ignore-table=digital_grinnell.cache_update --ignore-table=digital_grinnell.cache_views \
  --ignore-table=digital_grinnell.cache_views_data --ignore-table=digital_grinnell.watchdog \
  digital_grinnell >> prod-export.sql
#
# Once the dump is complete, return to the host...
exit
# ...and copy the .sql backup to /mnt/mcfatem/DG-MASTER/Backup-Data/prod-export.sql like so:
sudo docker cp isle-mysql-dg:/prod-export.sql /mnt/mcfatem/DG-MASTER/Backup-Data/prod-export.sql
