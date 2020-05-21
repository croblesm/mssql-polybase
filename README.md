# Custom mssql-polybase

## Build image

Let's create a customized SQL Server polybase image with Ubuntu 16.04 and SQL Server 2019.

```Docker
docker build . -t mssql-polybase -f Dockerfile
```
This Docker image size is around 1.5 GBs.

## Create container

Let's create a new SQL Server container based on the previous ```mssql-polybase``` created in the previous step.

```Docker
docker container run \
    --name sql-polybase \
    --env 'ACCEPT_EULA=Y' \
    --env 'MSSQL_SA_PASSWORD=_SqLr0ck$_' \
    --publish 1433:1433 \
    --detach mssql-polybase
```
    
## Configure polybase

Let's connect to the container we just created

```Docker
docker exec -it sql-polybase "sqlcmd -U sa -P '_SqLr0ck$_'"
```

Configuring polybase for this SQL Server container

```SQL
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
GO
RECONFIGURE;
```
