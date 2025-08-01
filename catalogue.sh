#! /bin/bash

echo "Disable Nodejs Module"
sudo dnf module disable nodejs -y
echo "Exit status: $?"

echo "Enable Nodejs 20 Module"
sudo dnf module enable nodejs:20 -y
echo "Exit status: $?"

echo " Install Nodejs"
sudo dnf install nodejs -y
echo "Exit status: $?"

echo " Add an Application User"
sudo useradd roboshop
echo "Exit status: $?"

echo " Create Application Directory"
mkdir /app
echo "Exit status: $?"

echo "Download the application code"
sudo curl -o /tmp/catalogue.zip https://roboshop-artifacts.s3.amazonaws.com/catalogue-v3.zip
echo "Exit status: $?"

echo "Extract the application code"
sudo unzip /tmp/catalogue.zip -d /app
echo "Exit status: $?"

echo "Install dependencies"
sudo npm install --prefix /app
echo "Exit status: $?"

echo " Copy Service File"
sudo cp catalogue.service /etc/systemd/system/catalogue.service
echo "Exit status: $?"

echo "Load the service"
sudo systemctl daemon-reload
echo "Exit status: $?"

echo "Enable and Start the catalogue service"
sudo systemctl enable catalogue
echo "Exit status: $"
sudo systemctl start catalogue
echo "Exit status: $"

echo "Copy Mongodb Repo"
sudo cp mongo.repo /etc/yum.repos.d/mongo.repo
echo "Exit status: $?"

echo "Install Mongodb Client"
sudo dnf install mongodb-mongosh -y
echo "Exit status: $?"

echo " Load Master Data"
mongosh --host 204.236.186.68 </app/db/master-data.js
echo "Exit status: $?"











