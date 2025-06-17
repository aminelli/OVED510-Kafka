# ETL KAFKA

## Fase creazione containers
```powershell
docker run --name test -it confluentinc/cp-kafka-connect /bin/bash
docker exec test confluent-hub install --component-dir confluent-hub-components --no-prompt debezium/debezium-connector-postgresql:1.1.0
docker exec test confluent-hub install --component-dir confluent-hub-components --no-prompt debezium/debezium-connector-mongodb:1.1.0
docker exec test confluent-hub install --component-dir confluent-hub-components --no-prompt confluentinc/kafka-connect-elasticsearch:10.0.1
#docker cp test
```


```shell
    #  =======================================================================
    # Per sistemi Linux, se necessario settare il parametro: 
    sysctl -w vm.max_map_count=262144
    # oppure (sempre in linux) modificare il file di conf.:
    #   Edit /etc/sysctl.conf
    #   Add Row vm.max_map_count=262144
```
```powershell 
    #  =======================================================================
    # Per sistemi Windows (WSL), se necessario lanciare sequenza di comandi: 
    wsl -d docker-desktop
    sysctl -w vm.max_map_count=262144
```



## Popolamento dati database Postgres

```powershell
docker exec -it postgres /bin/bash
psql -U postgres-user customers
```

```sql
CREATE TABLE customers (id TEXT PRIMARY KEY, name TEXT, age INT);
INSERT INTO customers (id, name, age) VALUES ('5', 'fred', 34);
INSERT INTO customers (id, name, age) VALUES ('7', 'sue', 25);
INSERT INTO customers (id, name, age) VALUES ('2', 'bill', 51);
```

## Popolamento dati database MongoDB

```powershell
docker exec -it mongo /bin/bash
mongo -u $MONGO_INITDB_ROOT_USERNAME -p mongo-pw admin
```

```javascript
// Primo comando
rs.initiate()

// Secondo Comando
use config

// Terzo comando
db.createRole({
    role: "dbz-role",
    privileges: [
        {
            resource: { db: "config", collection: "system.sessions" },
            actions: [ "find", "update", "insert", "remove" ]
        }
    ],
    roles: [
       { role: "dbOwner", db: "config" },
       { role: "dbAdmin", db: "config" },
       { role: "readWrite", db: "config" }
    ]
})

// Quarto Comando
use admin


// Quinto Comando
db.createUser({
  "user" : "dbz-user",
  "pwd": "dbz-pw",
  "roles" : [
    {
      "role" : "root",
      "db" : "admin"
    },
    {
      "role" : "readWrite",
      "db" : "logistics"
    },
    {
      "role" : "dbz-role",
      "db" : "config"
    }
  ]
})


// Sesto Comando
use logistics

// Settimo comando
db.createCollection("orders")

// Ottavo comando
db.createCollection("shipments")

// Inserts
db.orders.insert({"customer_id": "2", "order_id": "13", "price": 50.50, "currency": "usd", "ts": "2020-04-03T11:20:00"})
db.orders.insert({"customer_id": "7", "order_id": "29", "price": 15.00, "currency": "aud", "ts": "2020-04-02T12:36:00"})
db.orders.insert({"customer_id": "5", "order_id": "17", "price": 25.25, "currency": "eur", "ts": "2020-04-02T17:22:00"})
db.orders.insert({"customer_id": "5", "order_id": "15", "price": 13.75, "currency": "usd", "ts": "2020-04-03T02:55:00"})
db.orders.insert({"customer_id": "7", "order_id": "22", "price": 29.71, "currency": "aud", "ts": "2020-04-04T00:12:00"})

// Inserts
db.shipments.insert({"order_id": "17", "shipment_id": "75", "origin": "texas", "ts": "2020-04-04T19:20:00"})
db.shipments.insert({"order_id": "22", "shipment_id": "71", "origin": "iowa", "ts": "2020-04-04T12:25:00"})
db.shipments.insert({"order_id": "29", "shipment_id": "89", "origin": "california", "ts": "2020-04-05T13:21:00"})
db.shipments.insert({"order_id": "13", "shipment_id": "92", "origin": "maine", "ts": "2020-04-04T06:13:00"})
db.shipments.insert({"order_id": "15", "shipment_id": "95", "origin": "florida", "ts": "2020-04-04T01:13:00"})

```


```powershell
docker exec -it ksqldb-cli ksql http://ksqldb-server:8088
```

```sql
-- KEYSQL COMMANDS
SET 'auto.offset.reset' = 'earliest';

```