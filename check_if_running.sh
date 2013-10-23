#!/bin/bash
PATH=/usr/local/bin:/bin:/usr/bin;
ps -ef | grep -v grep | grep -q node;
if [ $? -eq 1 ]
then
echo | date;
echo "Server restarted." | /usr/sbin/sendmail brandontkrieger@gmail.com;
cd /home/ec2-user/server/server && nohup 2>&1 /usr/local/bin/cake run &
fi

