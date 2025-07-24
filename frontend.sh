!# /bin/bash

# Install Nginx
sudo dnf module disable nginx -y
sudo dnf module enable nginx:1.24 -y
sudo dnf install nginx -y

# Start and Enable Nginx Service
sudo systemctl enable nginx
sudo systemctl start nginx

