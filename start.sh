#!/bin/sh

echo 'Updating CouchPotato...'
git pull

echo 'Starting CouchPotato...'
exec ./CouchPotato.py --data_dir=/datadir --config_file=/datadir/config.ini
