#!/usr/bin/env bash

if [ "$#" -ne 3 ]; then 
	echo "Usage: $0 <file_path> <username> <ip>"
	exit 1
fi

file_path="$1"
username="$2"
ip="$3"

echo "Tranferring file"
if [ -d "$file_path" ]; then
	    scp -r "$file_path" "${username}@${ip}:~/"
    else
	        scp "$file_path" "${username}@${ip}:~/"
fi
