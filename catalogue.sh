#! /bin/bash
source ./common.sh
app_name=catalogue

NODEJS

echo "Copy Mongodb Repo"
sudo cp mongo.repo /etc/yum.repos.d/mongo.repo
echo "Exit status: $?"

echo "Install Mongodb Client"
sudo dnf install mongodb-mongosh -y
echo "Exit status: $?"

echo " Load Master Data"
mongosh --host 172.31.24.208 </app/db/master-data.js
echo "Exit status: $?"











