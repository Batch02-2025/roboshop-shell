#! /bin/bash
source ./common.sh
component=catalogue

NODEJS

echo "Copy Mongodb Repo"
sudo cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
echo "Exit status: $?"

echo "Install Mongodb Client"
sudo dnf install mongodb-mongosh -y &>>$LOG_FILE
echo "Exit status: $?"

echo " Load Master Data"
mongosh --host 172.31.24.208 </app/db/master-data.js &>>$LOG_FILE
echo "Exit status: $?"











