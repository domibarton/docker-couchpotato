#!/bin/sh
cd /couchpotato
git pull
./CouchPotato.py --datadir=/datadir --config_file=/datadir/config.ini
