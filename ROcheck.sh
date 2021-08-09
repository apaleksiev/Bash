#!/bin/bash

# this will check if there are any read only filesystems on the system
# For Ubuntu systems- ignore snap filesystems as they are virtual


READONLY=$(grep ro, /proc/mounts | grep -v tmpfs | grep -v snap )
if [[ $READONLY ]];
then
	printf "Read-Only filesystems detected: \n"
	echo "$READONLY"
fi 
