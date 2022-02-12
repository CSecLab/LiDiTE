# camuda-scadalts-db

The Camunda and Scada LTS database contents

## Backing up

Generate with

```sh
echo 'USE scadalts;' > config/camunda-scadalts-db/settings.sql
sudo docker-compose -f docker-compose.base.yml -f docker-compose.sv.yml exec scada_db mysqldump scadalts \
  -u root --password=root \
  --no-data --routines \
  >> config/camunda-scadalts-db/settings.sql
sudo docker-compose -f docker-compose.base.yml -f docker-compose.sv.yml exec scada_db mysqldump scadalts \
  -u root --password=root \
  --no-create-info \
  --hex-blob --extended-insert \
  --ignore-table=scadalts.events \
  --ignore-table=scadalts.pointValues \
  --ignore-table=scadalts.pointValueAnnotations \
  >> config/camunda-scadalts-db/settings.sql
```

## Restoring

Restore with

```sh
sudo docker-compose -f docker-compose.base.yml -f docker-compose.sv.yml exec -T scada_db mysql -u root --password=root scadalts < config/camunda-scadalts-db/settings.sql
```
