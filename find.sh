#!/bin/bash
## find the largest 20 files in your current filesystem sorted from largest to smallest

for i in $(find . -xdev -size +1000000c -type f -exec du -m {} \; 2>/dev/null | sort -n | tail -20 | awk '{print $2}'); do ls -la --block-size=M $i; done
