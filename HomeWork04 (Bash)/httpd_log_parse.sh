#!/usr/bin/env bash
#
# need 'mailx' app for sending email
#
lock=/tmp/parselock
last_hour=$(date -d -1hour +'%d/%b/%Y:%H')
email=email@example.com
host=$(hostname)
log=/var/log/httpd/access_log
temp_log=/tmp/parse_httpd.log

if [ -f $lock ]

then
        echo "File is busy"
        exit 1
else
        touch $lock
        trap 'rm -f $lock; exit $?' INT TERM EXIT

echo 'Access.log parsing from' $(date -d -1hour +'%H:%M') to  $(date +'%H:%M')

echo 'Top 10 IP:' >> $temp_log
grep $last_hour $log | awk '{print $1}' | uniq -dc | sort -n | tail -n10 >> $temp_log

echo '' >> $temp_log

echo 'Top 10 URL:' >> $temp_log
grep $last_hour $log | awk '{print $7}' | uniq -dc | sort -n | tail -n10 >> $temp_log

echo '' >> $temp_log

echo 'httpd queries stats:' >> $temp_log
grep $last_hour $log | awk '{print $9}' | sort | uniq -c >> $temp_log

echo '' >> $temp_log

cat $temp_log | mail -s "httpd on $host stats" $email

rm -f $temp_log
rm -f $lock
        trap - INT TERM EXIT
fi
