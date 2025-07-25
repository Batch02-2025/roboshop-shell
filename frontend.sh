#! /bin/bash

echo "==== Disable Nginx Module ===="
sudo dnf module disable nginx -y
echo "Exit status: $?"

echo "=== Enable Nginx Module 1.24 ===="
sudo dnf module enable nginx:1.24 -y
echo "Exit status: $?"

echo "===== Install Nginx ====="
sudo dnf install nginx -y
echo "Exit status: $?"

echo "===== Remove the default content that web server is serving ====="
sudo rm -rf /usr/share/nginx/html/*
echo "Exit status: $?"

echo "===== Download the frontend content ====="
sudo curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
echo "Exit status: $?"

echo "===== Extract the frontend content ====="
sudo unzip /tmp/frontend.zip -d /usr/share/nginx/html
echo "Exit status: $?"

echo "===== Nginx Reverse Proxy Configuration ====="
cp nginx.conf /etc/nginx/nginx.conf
echo "Exit status: $?"

echo "===== Start and Enable Nginx Service ====="
sudo systemctl enable nginx
echo "Exit status: $?"
sudo systemctl start nginx
echo "Exit status: $?"