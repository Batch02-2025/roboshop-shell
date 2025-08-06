#!/bin/bash
LOG_FILE=/tmp/roboshop.log
dir_path=$(pwd)
rm -f /tmp/roboshop.log

NODEJS() {
  echo "Disable Nodejs Module"
  sudo dnf module disable nodejs -y &>>$LOG_FILE
  echo "Exit status: $?"

  echo "Enable Nodejs 20 Module"
  sudo dnf module enable nodejs:20 -y &>>$LOG_FILE
  echo "Exit status: $?"

  echo " Install Nodejs"
  sudo dnf install nodejs -y &>>$LOG_FILE
  echo "Exit status: $?"

  APP_SETUP

  echo "Install dependencies"
  sudo npm install --prefix /app &>>$LOG_FILE
  echo "Exit status: $?"

  SYSTEMD_SETUP
}

APP_SETUP() {

 echo " Add an Application User"
  id roboshop
  if [ $? -ne 0 ]
  then
    sudo useradd roboshop &>>$LOG_FILE
  fi
 echo "Exit status: $?"

 echo " Create Application Directory"
  if [ ! -d "/app" ];then
    mkdir /app &>>$LOG_FILE
  fi
 echo "Exit status: $?"

 echo "Download the application code"
 sudo curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip &>>$LOG_FILE
 echo "Exit status: $?"

 echo "Extract the application code"
 sudo unzip /tmp/$component.zip -d /app &>>$LOG_FILE
 echo "Exit status: $?"

}

SYSTEMD_SETUP() {

 echo " Copy Service File"
 sudo cp $component.service /etc/systemd/system/$component.service &>>$LOG_FILE
 echo "Exit status: $?"

 echo "Load the service"
 sudo systemctl daemon-reload &>>$LOG_FILE
 echo "Exit status: $?"

 echo "Enable and Start the catalogue service"
 sudo systemctl enable $component &>>$LOG_FILE
 echo "Exit status: $?"
 sudo systemctl start $component &>>$LOG_FILE
 echo "Exit status: $?"

}

JAVA() {
  echo "Install Java"
  sudo dnf install java-1.8.0-openjdk -y &>>$LOG_FILE
  echo "Exit Status: $?"

  echo "Installing Maven"
  sudo dnf install maven -y &>>$LOG_FILE
  echo "Exit Status: $?"

  APP_SETUP

  echo "Install Dependencies"
  cd /app
  sudo mvn clean package  &>>$LOG_FILE
  sudo mv target/shipping-1.0.jar shipping.jar &>>$LOG_FILE
  echo "Exit Status: $?"


  SYSTEMD_SETUP

}
