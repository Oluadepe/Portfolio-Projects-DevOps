#!/bin/bash
echo "Nginx is Next"
sudo apt update
sudo apt install nginx -y

echo "Restarting Nginx"
sudo systemctl reload nginx

echo "Check status of Nginx Installation"
sudo systemctl status nginx
