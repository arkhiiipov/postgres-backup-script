## pg-dump
 Dumps postgres db of all databases that are available on the host. Register variables.
   
```bash
git clone git@github.com:arkhiiipov/pg-dump.git 
cd pg-dump &&  chmod +x pg-dump-backup.sh
crontab -e
*/10 * * * * cd /home && ./pg-dump-backup.sh
```
