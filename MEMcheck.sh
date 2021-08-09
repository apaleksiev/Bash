#!/bin/bash

# this script will check the memory usage on a system and compare it to the set threshold
# Ultimately, using this script with cut will result in  a less than 1% discrepency, as I cut the floating point #

THRESHOLD=85
USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d "." -f 1)
if (( $USAGE >= $THRESHOLD ));
then
	echo "Memory Usage is over the threshold! Current usage is $USAGE! The following processes are using the most memory:"
	printf "\n"
	ps -eocomm,pmem | egrep -v '(0.0)|(%MEM)' | sort -nr -k 2 | head -20
else
	echo "Memory usage is under the configured threshold."
fi



