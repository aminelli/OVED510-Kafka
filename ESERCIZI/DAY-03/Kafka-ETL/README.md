
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


