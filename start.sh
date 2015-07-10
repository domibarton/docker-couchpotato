#!/bin/sh
cd /couchpotato
git pull
./CouchPotato.py --data_dir=/datadir --config_file=/datadir/config.ini
