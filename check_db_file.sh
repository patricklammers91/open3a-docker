#!/bin/sh

if [ ! -f /var/www/html/system/DBData/Installation.pfdb.php ] 
then
  cp /var/www/html/startup/Installation.pfdb.php /var/www/html/system/DBData/Installation.pfdb.php
  chmod 666 /var/www/html/system/DBData/Installation.pfdb.php
fi

exec /usr/local/bin/apache2-foreground