#!/bin/bash
source ./common.sh
component=dispatch

echo "Install Golang"
sudo dnf install golang -y &>>$LOG_FILE
echo "Exit Status: $?"

APP_SETUP

echo " Install Dependencies"
cd /app &>>$LOG_FILE
sudo go mod init dispatch &>>$LOG_FILE
sudo go get &>>$LOG_FILE
sudo go build &>>$LOG_FILE
echo "Exit Status: $?"

SYSTEMD_SETUP
