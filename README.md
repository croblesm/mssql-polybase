# Custom mssql-polybase

## Build image

This customized Docker image will let 1.5 GBs

```Docker
docker build . -t mssql-polybase -f Dockerfile
```

## Create container

```Docker
docker container run \
    --name sql-polybase \
    --env 'ACCEPT_EULA=Y' \
    --env 'MSSQL_SA_PASSWORD=_SqLr0ck$_' \
    --publish 1433:1433 \
    --detach mssql-polybase
```
    
## Configure polybase

```Docker
docker exec -it sql-polybase "bash"
```

```SQL
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE;
sqlcmd -U sa -P '123MyP@assword'
```
