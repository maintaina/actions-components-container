#!/usr/bin/env bash
echo "Config stage"
## Extract environment variables to determine UUT
cp /srv/runtime/components/config/maintaina.conf.dist /srv/runtime/components/config/conf.php

echo "Unit: $1"
echo "Extra: $2"

export UUT=view
export BRANCH=FRAMEWORK_6_0

echo "Setup UUT stage"
/srv/runtime/components/bin/horde-components git clone $UUT
cd /srv/git/$UUT
/srv/runtime/components/bin/horde-components git checkout $UUT $BRANCH
composer install

echo "Run components qc action"
/srv/runtime/components/bin/horde-components qc

echo "Handing over to pid 1 command"
exec "$@"
