#!/usr/bin/env bash

if [ "$#" -ne 4 ]; then
	  echo "Usage: $0 <username> <ip> <file_path_remote> <file_path_local>"
	    exit 1
fi

username="$1"
ip="$2"
file_path_remote="$3"
file_path_local="$4"

echo "Transferring file"

echo "Copying directory '$file_path_remote' to '$file_path_local'..."
scp -r "${username}@${ip}:${file_path_remote}" "${file_path_local}"
