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
# Finally, start CouchPotato.
#

CONFIG=${CONFIG:-/datadir/config.ini}
echo "Starting CouchPotato..."
exec su -pc "./CouchPotato.py --data_dir=$(dirname ${CONFIG}) --config_file=${CONFIG}" ${USER}
