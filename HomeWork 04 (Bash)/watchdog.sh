#!/usr/bin/env bash
#
# need 'mailx' app for sending email
#
email=email@mail.com
host=$(hostname)
service_name=nginx
chek_status=$(systemctl status $service_name | grep dead | awk '{print $3}' | cut -c 2-5)

if
[ "$chek_status" == "dead" ];

then

echo 'nginx dead, reloading nginx' | mail -s "nginx on $host dead" $email
systemctl restart nginx

fi
