# mssql-polybase


docker build . -t mssql-polybase -f Dockerfile

real    2m28.414s
user    0m0.198s
sys     0m0.195s

mssql-polybase      1.56GBdo

docker container run \
    --name sql-polybase \
    -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=123MyP@assword' \
    -p 1433:1433 -d mssql-polybase && sleep 1 && docker logs sql-polybase -f

exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE;
sqlcmd -U sa -P '123MyP@assword'
