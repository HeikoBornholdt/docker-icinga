#!/bin/bash

service postfix start
service icinga start
/usr/sbin/apache2ctl start

tail -F /var/log/mail.log /var/log/mail.err /var/log/icinga/icinga.log /var/log/apache2/access.log /var/log/apache2/error.log & pid=$!
echo "tail -F running in $pid"

sleep 1

trap "echo 'stopping processes' ; kill $pid $(cat /var/run/icinga/icinga.pid) $(cat  /var/run/apache2/apache2.pid)" SIGTERM SIGINT

echo "Waiting for signal SIGINT/SIGTERM"
wait
