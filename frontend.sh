#! /bin/bash

# Install Nginx
sudo dnf module disable nginx -y
sudo dnf module enable nginx:1.24 -y
sudo dnf install nginx -y

# Remove the default content that web server is serving
sudo rm -rf /usr/share/nginx/html/*

# Download the frontend content
sudo curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip

# Extract the frontend content
sudo unzip /tmp/frontend.zip -d /usr/share/nginx/html

# Nginx Reverse Proxy Configuration
cp nginx.conf /etc/nginx/nginx.conf

# Start and Enable Nginx Service
sudo systemctl enable nginx
sudo systemctl start nginx