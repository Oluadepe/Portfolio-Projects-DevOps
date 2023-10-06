#!/bin/bash

echo "Updating and Upgrading Server"
sudo apt update && sudo apt upgrade -y

echo "Installing Dependencies"
sudo apt install software-properties-common -y

echo "Adding Deadsnake PPA to APT package manager source list"
sudo add-apt-repository ppa:deadsnakes/ppa -y

echo "Installing Python 3.11"
sudo apt install python3.11

echo "checking Python version"
python3.11 --version
