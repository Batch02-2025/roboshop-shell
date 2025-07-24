!# /bin/bash

# Install Nginx
sudo dnf install nginx -y

# Start and Enable Nginx Service
sudo systemctl enable nginx
sudo systemctl start nginx

