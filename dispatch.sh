#!/bin/bash
source ./common.sh
component=dispatch

echo "Install Golang"
sudo dnf install golang -y
echo "Exit Status: $?"

APP_SETUP

echo " Install Dependencies"
sudo go mod init dispatch --prefix /app
sudo go get
sudo go build
echo "Exit Status: $?"

SYSTEMD_SETUP
