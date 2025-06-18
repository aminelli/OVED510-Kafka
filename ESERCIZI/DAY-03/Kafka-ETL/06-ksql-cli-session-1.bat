@echo off

docker exec -it ksqldb-cli ksql http://ksqldb-server:8088

docker run -it --network deb-etl_default --name ksqldb-cli2 confluentinc/ksqldb-cli:0.29.0 /bin/sh
