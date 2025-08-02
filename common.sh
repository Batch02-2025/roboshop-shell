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
 sudo curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
 echo "Exit status: $?"

 echo "Extract the application code"
 sudo unzip /tmp/$component.zip -d /app
 echo "Exit status: $?"

}

SYSTEMD_SETUP() {

 echo " Copy Service File"
 sudo cp $component.service /etc/systemd/system/$component.service
 echo "Exit status: $?"

 echo "Load the service"
 sudo systemctl daemon-reload
 echo "Exit status: $?"

 echo "Enable and Start the catalogue service"
 sudo systemctl enable $component
 echo "Exit status: $"
 sudo systemctl start $component
 echo "Exit status: $"

}
