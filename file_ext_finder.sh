#!/bin/bash

read -p "Enter your file extension: " ext
case $ext in
	".txt")
		ls -lrt *.txt
		;;
	".sh")
		ls -lrt *.sh
		;;
	".html")
		ls -lrt *.html
		;;
	".log")
		ls -lrt *.log
		;;
	".src")
		ls -lrt *.src
		;;
	".tar")
		ls -lrt *.tar
		;;
	".gzip")
		ls -lrt *.gzip
		;;
	".zip")
		ls -lrt *.zip
		;;
	*)
		echo "invalid file extension!"
		;;
esac
