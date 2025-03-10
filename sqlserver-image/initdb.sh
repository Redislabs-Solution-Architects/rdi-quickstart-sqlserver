#!/bin/bash
if [ ! -f /var/opt/mssql/data/Chinook.mdf ]; then
  #Wait for SQL Server to be available
  while true; do
    if [ ! $(/opt/mssql-tools18/bin/sqlcmd -No -h -1 -t 1 -S localhost -U ${MSSQL_USER} -P "${MSSQL_SA_PASSWORD}" -Q "SET NOCOUNT ON; Select SUM(state) from sys.databases") ]; then
      sleep 2
    else
      break
    fi
  done
  echo "Creating Chinook database..."
  sed -e "s/<DBZUSER>/${DBZUSER}/g" \
      -e "s/<DBZUSER_PASSWORD>/${DBZUSER_PASSWORD}/g" /tmp/CDC_Config.template > /tmp/CDC_Config.sql
  /opt/mssql-tools18/bin/sqlcmd -No -S localhost -U ${MSSQL_USER} -P "${MSSQL_SA_PASSWORD}" -i /tmp/Chinook_SqlServer.sql
  /opt/mssql-tools18/bin/sqlcmd -No -S localhost -U ${MSSQL_USER} -P "${MSSQL_SA_PASSWORD}" -i /tmp/CDC_Config.sql
fi &
/opt/mssql/bin/sqlservr
