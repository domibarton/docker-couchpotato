#!/bin/bash
set -e

#
# Display settings on standard out.
#

USER="couchpotato"

echo "CouchPotato settings"
echo "===================="
echo
echo "  User:       ${USER}"
echo "  UID:        ${CP_UID:=666}"
echo "  GID:        ${CP_GID:=666}"
echo
echo "  Config:     ${CONFIG:=/datadir/config.ini}"
echo "  Version:    ${VERSION:=master}"
echo

#
# Change UID / GID of CouchPotato user.
#

printf "Updating UID / GID... "
[[ $(id -u ${USER}) == ${CP_UID} ]] || usermod  -o -u ${CP_UID} ${USER}
[[ $(id -g ${USER}) == ${CP_GID} ]] || groupmod -o -g ${CP_GID} ${USER}
echo "[DONE]"

#
# Set directory permissions.
#

printf "Set permissions... "
touch ${CONFIG}
chown -R ${USER}: /couchpotato
chown ${USER}: /datadir /media $(dirname ${CONFIG})
echo "[DONE]"

#
# Update CouchPotato and checkout requested version.
#

printf "Updating CouchPotato git repository... "
git pull -q
echo "[DONE]"

printf "Getting current version... "
CURRENT_VERSION=$(git rev-parse --abbrev-ref HEAD)
echo "[${CURRENT_VERSION}]"

if [[ "${CURRENT_VERSION}" == "${VERSION}" ]]
then
    printf "Checking out CouchPotato version '${VERSION}'... "
    git checkout -q ${VERSION}
    echo "[DONE]"
fi

#
# Finally, start CouchPotato.
#

CONFIG=${CONFIG:-/datadir/config.ini}
echo "Starting CouchPotato..."
exec ./CouchPotato.py --data_dir=$(dirname ${CONFIG}) --config_file=${CONFIG}
