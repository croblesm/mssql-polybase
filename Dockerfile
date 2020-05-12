# SQL Server Command Line Tools - custom image
# From Ubuntu 16.04 as base image
FROM ubuntu:16.04 as base

# Labels
LABEL maintainer="crobles@dbamastery.com"
LABEL org.label-schema.schema-version="1.0"
LABEL org.label-schema.name="mssql-polybase"
LABEL org.label-schema.description="mssql-polybase updated image"
LABEL org.label-schema.url="http://dbamastery.com"

# Installing system utilities
RUN apt-get update && \
    apt-get install -y apt-transport-https curl && \
    # Adding custom MS repository
    curl https://packages.microsoft.com/keys/microsoft.asc | apt-key add - && \
    curl https://packages.microsoft.com/config/ubuntu/16.04/mssql-server-2019.list > /etc/apt/sources.list.d/mssql-server-2019.list

# From base image
FROM base as release

# Installing SQL Server drivers and tools
RUN apt-get update && \
    apt-get install -y mssql-server-polybase && \
    # Cleanup the Dockerfile
    apt-get clean && \
    rm -rf /var/lib/apt/lists
    
# Adding SQL Server tools to $PATH
ENV PATH=$PATH:/opt/mssql-tools/bin
# Run SQL Server process
CMD /opt/mssql/bin/sqlservr
