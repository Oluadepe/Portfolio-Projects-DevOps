#!/bin/bash

# Check if the required arguments are provided
if [ "$#" -ne 3 ]; then
	            echo "Usage: $0 <GitHub_Username> <GitHub_Repository> <Access_Token>"
		                    exit 1
fi

# GitHub repository information
repo_owner="$1"
repo_name="$2"
access_token="$3"

# Destination directory for cloning the repository
destination_dir="${repo_name}"  # Replace with your desired destination directory

echo "Cloning Repo to Destination"
# Clone the GitHub repository using the access token for authentication
git clone "https://${access_token}@github.com/${repo_owner}/${repo_name}.git" "$destination_dir"

echo "Changing Directory and Storing Git Credentials"
cd ${repo_name} && git config credential.helper store
