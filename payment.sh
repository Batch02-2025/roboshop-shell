#!/bin/bash
source ./common.sh
component=payment

echo "Install Python"
sudo dnf install python3 gcc python3-devel -y
echo "Exit Status: $?"

APP_SETUP

echo " Install Dependencies"
sudo pip3 install -r requirements.txt --prefix /app
echo "Exit Status: $?"

SYSTEMD_SETUP


