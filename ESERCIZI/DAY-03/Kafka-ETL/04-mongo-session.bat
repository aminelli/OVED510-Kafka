@echo off

docker exec -it mongo /bin/bash


echo "mongo -u $MONGO_INITDB_ROOT_USERNAME -p mongo-pw admin"


