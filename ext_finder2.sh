#!/bin/bash
#file extension finder with menu

clear
echo -e "\n\tFile Extension Finder\n"
PS3="Select an option and press Enter: "

select i in .txt .sh .html .log .src .tar .gzip .zip Quit
do
  case $i in
	.txt)
		ls -lrt *.txt
		;;
	.sh)
		ls -lrt *.sh
		;;
	.html)
		ls -lrt *.html
		;;
	.log)
		ls -lrt *.log
		;;
	.src)
		ls -lrt *.src
		;;
	.tar)
		ls -lrt *.tar
		;;
	.gzip)
		ls -lrt *.gzip
		;;
	.zip)
		ls -lrt *.zip
		;;
	Quit)  
	       	break
		;;
esac
done
