#!/usr/bin/env bash
echo "Config stage"
## Extract environment variables to determine UUT


echo "Setup UUT stage"


echo "Run components action(s)"
php7 /srv/www/horde-components/vendor/bin/horde-components $1 $2 $3

echo "Handing over to pid 1 command"
exec "$@"
