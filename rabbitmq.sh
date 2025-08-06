#!/bin/bash
LOG_FILE=/tmp/roboshop.log

echo " Copy Rabbitmq repo"
sudo cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo &>>$LOG_FILE
echo "Exit Status: $?"

echo " Install RabbitMQ"
sudo dnf install rabbitmq-server -y &>>$LOG_FILE
echo "Exit Status: $?"

echo " Enable and Start Service"
sudo systemctl enable rabbitmq-server &>>$LOG_FILE
echo "Exit Status: $?"
sudo systemctl start rabbitmq-server &>>$LOG_FILE
echo "Exit Status: $?"

echo "Adding the User"
sudo rabbitmqctl add_user roboshop roboshop123 &>>$LOG_FILE
sudo rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$LOG_FILE
echo "Exit Status: $?"
