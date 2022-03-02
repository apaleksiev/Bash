#!/bin/bash
#script to check if a particular application process is running, and start it if not
#edit the variables to reflect the application and its path

APP_SERVICE="/usr/local/sbin/app1"
TIMESTAMP=$(date +%m%d%y%H%M%S)
APP_LOGS="/usr/local/log/app1.log"
APP_SERVICE_COUNT=$(ps -ef | grep -v grep | grep "$APP_SERVICE" | wc -l)

[ -s $APP_LOGS ] || touch $APP_LOGS

if [[ $APP_SERVICE_COUNT == 0 ]]
then
	echo "Application Process is not running, attempting Restart..."
	echo "Application Error- $TIMESTAMP - $APP_SERVICE DOWN - Attempting Restart..." >> $APP_LOGS
	su - app1 -c '/usr/local/sbin/app1 start 2>&1' >> $APP_LOGS
fi



