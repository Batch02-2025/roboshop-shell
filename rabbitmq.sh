#!/bin/bash

echo " Copy Rabbitmq repo"
sudo cp rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
echo "Exit Status: $?"

echo " Install RabbitMQ"
sudo dnf install rabbitmq-server -y
echo "Exit Status: $?"

echo " Enable and Start Service"
sudo systemctl enable rabbitmq-server
echo "Exit Status: $?"
sudo systemctl start rabbitmq-server
echo "Exit Status: $?"

echo "Adding the User"
sudo rabbitmqctl add_user roboshop roboshop123
sudo rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
echo "Exit Status: $?"
