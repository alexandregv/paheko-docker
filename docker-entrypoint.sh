#!/bin/sh
set -e

# Make sure the configuration is readable+writable by www-data (apache user)
chown www-data:www-data /var/www/paheko/config.local.php

# Configure the timezone
[ -z $TZ ] && export TZ=UTC
ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
printf "[PHP]\ndate.timezone = \"$TZ\"\n" > /usr/local/etc/php/conf.d/tzone.ini

exec docker-php-entrypoint apache2-foreground "$@"
