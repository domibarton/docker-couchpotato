#!/bin/sh

echo "Updating CouchPotato git repository..."
git pull

if [[ -n "${VERSION}" ]]
then
    echo "Checking out SABnzbd version '${VERSION}'..."
    git checkout ${VERSION}
fi

CONFIG=${CONFIG:-/datadir/config.ini}
echo "Starting CouchPotato with config '${CONFIG}'..."
exec ./CouchPotato.py --data_dir=/datadir --config_file=${CONFIG}
