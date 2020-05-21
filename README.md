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

Let's connect to the container we just created, using SQLCMD
> You should have SQLCMD already installed in your host machine, for more information check [here](https://docs.microsoft.com/en-us/sql/tools/sqlcmd-utility?view=sql-server-ver15)

```bash
sqlcmd -U sa -P '_SqLr0ck$_'
```

Configure polybase for this SQL Server container

```SQL
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
GO
RECONFIGURE;
GO
```
In case you want to make sure Polybase is working. You can use the following quick guide:

```sql
CREATE DATABASE PolyTestDb
GO

USE PolyTestDb
GO

CREATE TABLE T1 (column1 nvarchar(50))
GO

INSERT INTO T1 values ('Hello PolyBase!')
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '_SqLr0ck$_'
GO

CREATE DATABASE SCOPED CREDENTIAL SaCredential WITH IDENTITY = 'sa', Secret = '_SqLr0ck$_'
GO

CREATE EXTERNAL DATA SOURCE loopback_data_src WITH (LOCATION = 'sqlserver://127.0.0.1', CREDENTIAL = SaCredential)
GO

CREATE EXTERNAL TABLE T1_external (column1 nvarchar(50))  with (location='PolyTestDb..T1', DATA_SOURCE=loopback_data_src)
GO

SELECT * FROM T1_external
GO
```

This customized image was created based on the original created by the Microsoft SQL Server team:
https://github.com/microsoft/mssql-docker/tree/master/linux/preview/examples/mssql-polybase

## Questions?
If you have questions or comments about this demo, don't hesitate to contact me at <crobles@dbamastery.com>

## Follow me
[![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_twitter_circle_color_107170.png)](https://twitter.com/dbamastery) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_github_circle_black_107161.png)](https://github.com/dbamaster) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_linkedin_circle_color_107178.png)](https://www.linkedin.com/in/croblesdba/) [![N|Solid](http://dbamastery.com/wp-content/uploads/2018/08/if_browser_1055104.png)](http://dbamastery.com/)