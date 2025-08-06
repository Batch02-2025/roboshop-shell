#!/bin/bash

echo "Install MySQL Server"
sudo dnf install mysql-server -y &>>$LOG_FILE
echo "Exit Status: $?"

echo "Enable and Start the Mysql service"
sudo systemctl enable mysqld &>>$LOG_FILE
echo "Exit Status: $?"
sudo systemctl start mysqld &>>$LOG_FILE
echo "Exit Status: $?"

echo "Steup Mysql Password"
sudo mysql_secure_installation --set-root-pass RoboShop@1 &>>$LOG_FILE
echo "Exit Status: $?"
