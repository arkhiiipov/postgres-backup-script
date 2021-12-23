#!/bin/bash


PROJECT=""
PGHOST=""
DBUSER=""
DIROUT=""
DATE=`date +%Y-%m-%d`

mkdir -p $DIROUT

IFS=$'\r\n' GLOBIGNORE='*' command eval  "DBs=($(PGPASSWORD='' psql -h $PGHOST -U $DBUSER -d postgres -c "SELECT datname FROM pg_database WHERE datistemplate = false and datname NOT like '%postgres%';
"  | head -n -2 | tail -n +3 | tr -d ' '))"
STATUS=()
for DBNAME in ${DBs[@]}; do
    mkdir -p $DIROUT/$DBNAME
    PGPASSWORD="" pg_dump -F t -h $PGHOST -p 5432 -U $DBUSER -d $DBNAME > $DIROUT/$DBNAME/$PROJECT-$DBNAME-$DATE.tar.gz
    STATUS+=$?
done

echo ${STATUS[*]}

if [[ ${STATUS[*]} =~ 0 ]]
    then echo 'OK'
else
  echo 'ERROR'
fi
