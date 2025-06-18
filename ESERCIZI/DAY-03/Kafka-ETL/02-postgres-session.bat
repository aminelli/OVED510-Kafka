@echo off

docker exec -it postgres psql -U postgres-user customers
