#! /bin/bash

echo "Disable Default Redis"
sudo dnf module disable redis -y &>>$LOG_FILE
echo "Exit status: $?"

echo "Enable Redis 7"
sudo dnf module enable redis:7 -y &>>$LOG_FILE
echo "Exit status: $?"

echo "Install Redis "
sudo dnf install redis -y &>>$LOG_FILE
echo "Exit status: $?"

echo "Update Redis Listen address & protected mode"
sudo sed -i -e '/^bind/ s/127.0.0.1/0.0.0.0/' -e '/protected-mode/ c protected-mode no' /etc/redis/redis.conf &>>$LOG_FILE
echo "Exit status: $?"

echo "Start and Enable the Redis serivce"
sudo systemctl enable redis &>>$LOG_FILE
echo "Exit status: $?"
sudo systemctl start redis &>>$LOG_FILE
echo "Exit status: $?"
