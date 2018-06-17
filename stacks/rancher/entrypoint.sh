#!/bin/bash
set -e

secrets_path="/run/secrets"
get_secret () {
   echo $(head -n 1 $secrets_path/$1 | tr -s "[:blank:]")
}

host=$(get_secret 'MYSQL_HOST')
echo "SECRET! host: $host"

sleep 1234567890

# /usr/bin/entry \
#     --db-host $(get_secret 'MYSQL_HOST') \
#     --db-name $(get_secret 'MYSQL_MYDB') \
#     --db-user $(get_secret 'MYSQL_USER') \
#     --db-pass $(get_secret 'MYSQL_PASS') \
#     --db-port 3306 --db-strict-enforcing

