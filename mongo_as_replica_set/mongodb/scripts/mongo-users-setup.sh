#!/bin/bash

echo "************************************************************"
echo "Begin setting up users..."
echo "************************************************************"

mongodb_setup_cmd="mongod"

echo "Starting the server";
$mongodb_setup_cmd &

fg

echo "Waiting for engine to start";
./mongo-engine-wait.sh no-ssl


# create root user
if [ ! -z "${MONGO_USER_ROOT_NAME+x}" ] && [ ! -z "${MONGO_USER_ROOT_PASSWORD+x}" ] ; then
# ,{ role: 'userAdminAnyDatabase', db: 'admin' },{ role: 'readWriteAnyDatabase', db: 'admin' },{ role: 'dbAdminAnyDatabase', db: 'admin' }
  mongo admin --eval "db.createUser({user: '$MONGO_USER_ROOT_NAME', pwd: '$MONGO_USER_ROOT_PASSWORD', roles:[{ role: 'root', db: 'admin' }]});"
else
  echo 'ERROR: Mongo root user credentials are not provided!';
  exit 1;
fi


echo "Shutting down...";
mongo admin --eval "db.shutdownServer();";

echo 'Sleeping 1 second...';
sleep 1;

echo "************************************************************"
echo "End Setting up users..."
echo "************************************************************"
