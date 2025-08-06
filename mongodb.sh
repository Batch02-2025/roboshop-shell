#! /bin/bash

echo "Copy Mongodb Repo file"
cp mongo.repo /etc/yum.repos.d/mongo.repo &>>$LOG_FILE
echo "Exit status: $?"

echo "Install MongoDB"
sudo dnf install mongodb-org -y &>>$LOG_FILE
echo "Exit status: $?"

echo "Start and Enable MongoDB Service"
systemctl enable mongod.service && systemctl start mongod.service &>>$LOG_FILE
echo "Exit status: $?"

echo "Update MongoDB Listen Address"
sudo sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>>$LOG_FILE
echo "Exit status: $?"

echo "Update the Mongodb service"
sudo systemctl restart mongod.service &>>$LOG_FILE
echo "Exit status: $?"

