!# /bin/bash

# Install Nginx
sudo dnf module disable nginx -y
sudo dnf module enable nginx:1.24 -y
sudo dnf install nginx -y

# Start and Enable Nginx Service
sudo systemctl enable nginx
sudo systemctl start nginx

# Remove the default content that web server is serving
sudo rm -rf /usr/share/nginx/html/*

# Download the frontend content
sudo curl -o /tmp/frontend.zip https://roboshopartifacts.s3.amazonaws.com/frontend-v3.zip

# Extract the frontend content
sudo cd /usr/share/nginx/html
sudo unzip /tmp/frontend.zip

# Nginx Reverse Proxy Configuration
