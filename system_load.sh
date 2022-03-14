#!/bin/bash
# This is a system-load monitoring script for Linux Operating Systems.
# Adjust SECS and INTERVAL variables as necessary

SECS=10
INTERVAL=5
OS=$(uname)


echo -e "Gathering CPU stats using sar...\n"
echo "There are $INTERVAL sampling periods, ran every $SECS seconds"
echo -e "\n...Gathering CPU stats, please hold...\n"

sar $SECS $INTERVAL | grep Average \
	| awk '{print $3, $4, $5, $8}' \
	| while read FIRST SECOND THIRD FOURTH
do
	echo -e "\nUser load is ${FIRST}%"
	echo "Nice load is ${SECOND}%"
	echo "System load is ${THIRD}%"
	echo -e "Idle time is ${FOURTH}%\n"
done





