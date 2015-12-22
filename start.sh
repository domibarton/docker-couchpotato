#!/bin/sh

if [[ -n "${VERSION}" ]]
then
    echo "Checking out SABnzbd version '${VERSION}'..."
    git checkout ${VERSION}
fi

echo "Updating CouchPotato..."
git pull

CONFIG=${CONFIG:-/datadir/config.ini}
echo "Starting CouchPotato with config '${CONFIG}'..."
exec ./CouchPotato.py --data_dir=/datadir --config_file=${CONFIG}
