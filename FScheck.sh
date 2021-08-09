#!/bin/bash
# This script will find filesystems that are over the disk usage threshold (85)
# and subsequently provide a list of the largest files in that filesystem

DU_THRESHOLD=85
for FS_USAGE in $(df -h | awk '{print $5,$6}' | egrep -v "*snap" | sort -Vr | cut -d "%" -f 1); do
	if (( $FS_USAGE >= $DU_THRESHOLD ));
	then
		echo "$FS_USAGE is over the configured threshold!"
		printf "\n"
		echo "Here are the files occupying the most space:"
		printf "\n"
		for i in $(find / -xdev -size +1000000c -type f -exec du -m {} \; 2>/dev/null | sort -n | tail -20 | awk '{print $2}'); do ls -la --block-size=M $i; done
	fi
done
if (( $FS_USAGE < $DU_THRESHOLD )); 
then
echo "All filesystems are under the configured health-check threshold"
fi

	

