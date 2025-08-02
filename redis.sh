#! /bin/bash

echo "Disable Default Redis"
sudo dnf module disable redis -y
echo "Exit status: $?"

echo "Enable Redis 7"
sudo dnf module enable redis:7 -y
echo "Exit status: $?"

echo "Install Redis "
sudo dnf install redis -y
echo "Exit status: $?"

echo "Update Redis Listen address & protected mode"
sudo sed -i '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no/' /etc/redis/redis.conf
echo "Exit status: $?"

echo "Start and Enable the Redis serivce"
sudo systemctl enable redis
echo "Exit status: $?"
sudo systemctl start redis
echo "Exit status: $?"
