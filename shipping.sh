#! /bin/bash
source ./common.sh
component=shipping

JAVA

echo "Install Mysql Client"
sudo dnf install mysql -y &>>$LOG_FILE
echo "Exit Status: $?"

echo " Load Schema"
mysql -h 172.31.19.140 -uroot -pRoboShop@1 < /app/db/schema.sql &>>$LOG_FILE
echo "Exit Status: $?"

echo "Create APP User"
mysql -h 172.31.19.140 -uroot -pRoboShop@1 < /app/db/appuser.sql &>>$LOG_FILE
echo "Exit Status: $?"

echo " Load Master Data "
mysql -h 172.31.19.140 -uroot -pRoboShop@1 < /app/db/masterdata.sql &>>$LOG_FILE
echo "Exit Status: $?"

echo " Restart Shipping Service"
sudo systemctl restart shipping &>>$LOG_FILE
echo "Exit Status: $?"





