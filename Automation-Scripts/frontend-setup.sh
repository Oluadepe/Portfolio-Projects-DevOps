#!/usr/bin/env bash

# Check if the required arguments are provided
if [ "$#" -ne 1 ]; then
   echo "Usage: $0 <GitHub_Username> <GitHub_Repository> <Access_Token>"
   exit 1
fi

repo_name="$1"

echo "Changing to Project Directory"
cd ${repo_name}

echo "Installing npm"
sudo npm install
npm run build
