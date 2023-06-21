#!/bin/bash

set -m;

# if [ "$MONGO_ROLE" == "primary" ] ; then
./mongo-users-setup.sh;
# fi

mongodb_cmd="mongod"

cmd="$mongodb_cmd"


if [ "$MONGO_AUTH" == "true" ] ; then
echo "auth enabled"
  cmd="$cmd --auth"
  # add a keyfile, this should be done outside the container if you actually multiple replicas lol
  openssl rand -base64 741 > /data/keyfile
  chmod 600 /data/keyfile
  cmd="$cmd --keyFile /data/keyfile"
else
echo "auth disabled"
  cmd="$cmd --noauth"
fi

# if [[ "$MONGO_OPLOG_SIZE" ]] ; then
  # cmd="$cmd --oplogSize $OPLOG_SIZE"
# fi
cmd="$cmd --oplogSize 128"

# if [[ "$MONGO_BIND_IP" ]] ; then
  # echo "MONGO_BIND_IP: Adding --bind_ip $MONGO_BIND_IP";
  # cmd="$cmd --bind_ip $MONGO_BIND_IP"
cmd="$cmd --bind_ip 0.0.0.0"
# cmd="$cmd --bind_ip_all"
# else
#   echo "MONGO_BIND_IP: Ignoring --bind_ip option";
# fi

if [[ "$MONGO_REPLICA_SET_NAME" ]] ; then
  cmd="$cmd --replSet $MONGO_REPLICA_SET_NAME"
fi


# openssl req -new -newkey rsa:2048 -days 3650 -nodes -x509 -subj '/CN=localhost' -keyout /etc/ssl/mongodb-cert.key -out /etc/ssl/mongodb-cert.crt
# cat /etc/ssl/mongodb-cert.key /etc/ssl/mongodb-cert.crt > /etc/ssl/mongodb.pem

# cmd="$cmd --sslMode requireSSL --sslPEMKeyFile /etc/ssl/mongodb.pem"

$cmd &

# if [ "$MONGO_ROLE" == "primary" ]; then
./mongo-rep-set-setup.sh
# fi

./mongo-db-setup.sh

# Create the health.check file indicating healthy
MONGO_CONTAINER_HEALTHCHECK_FILE_PATH=${MONGO_CONTAINER_HEALTHCHECK_FILE_PATH:-/data/health.check}
echo '1' >> "$MONGO_CONTAINER_HEALTHCHECK_FILE_PATH"

fg
