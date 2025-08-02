#!/bin/bash
dir_path=$(pwd)


NODEJS() {
  echo "Disable Nodejs Module"
  sudo dnf module disable nodejs -y
  echo "Exit status: $?"

  echo "Enable Nodejs 20 Module"
  sudo dnf module enable nodejs:20 -y
  echo "Exit status: $?"

  echo " Install Nodejs"
  sudo dnf install nodejs -y
  echo "Exit status: $?"

  APP_SETUP

  echo "Install dependencies"
  sudo npm install --prefix /app
  echo "Exit status: $?"

  SYSTEMD_SETUP
}

APP_SETUP() {

 echo " Add an Application User"
 sudo useradd roboshop
 echo "Exit status: $?"

 echo " Create Application Directory"
 mkdir /app
 echo "Exit status: $?"

 echo "Download the application code"
 sudo curl -o /tmp/$app_name.zip https://roboshop-artifacts.s3.amazonaws.com/$app_name-v3.zip
 echo "Exit status: $?"

 echo "Extract the application code"
 sudo unzip /tmp/$app_name.zip -d /app
 echo "Exit status: $?"

}

SYSTEMD_SETUP() {

 echo " Copy Service File"
 sudo cp $app_name.service /etc/systemd/system/$app_name.service
 echo "Exit status: $?"

 echo "Load the service"
 sudo systemctl daemon-reload
 echo "Exit status: $?"

 echo "Enable and Start the catalogue service"
 sudo systemctl enable $app_name
 echo "Exit status: $"
 sudo systemctl start $app_name
 echo "Exit status: $"

}
