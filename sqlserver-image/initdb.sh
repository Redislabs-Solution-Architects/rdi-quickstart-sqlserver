#!/bin/bash
if ! [ -f /var/opt/mssql/data/Chinook.mdf ]; then
  while ! </dev/tcp/localhost/1433 2>/dev/null; do
    sleep 2
  done
  echo "Creating Chinook database..."
  sed -e "s/<DBZUSER>/${DBZUSER}/g" \
      -e "s/<DBZUSER_PASSWORD>/${DBZUSER_PASSWORD}/g" /tmp/CDC_Config.template > /tmp/CDC_Config.sql
  /opt/mssql-tools18/bin/sqlcmd -No -S localhost -U ${MSSQL_USER} -P "${MSSQL_SA_PASSWORD}" -i /tmp/Chinook_SqlServer.sql
  /opt/mssql-tools18/bin/sqlcmd -No -S localhost -U ${MSSQL_USER} -P "${MSSQL_SA_PASSWORD}" -i /tmp/CDC_Config.sql
fi &
/opt/mssql/bin/sqlservr
