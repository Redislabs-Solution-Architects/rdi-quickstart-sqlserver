FROM mcr.microsoft.com/mssql/server:2022-latest

COPY Chinook_SqlServer.sql /tmp
COPY CDC_Config.template /tmp
COPY --chown=mssql:mssql initdb.sh /

USER mssql
ENTRYPOINT ["/bin/bash", "/initdb.sh"]
