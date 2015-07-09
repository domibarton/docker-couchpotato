#!/bin/sh
cd /sickbeard
git pull
./SickBeard.py --nolaunch --datadir=/datadir --config=/datadir/config.ini
