#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPTNAME=$(echo $0 | cut -d "." -f1)
LOGFILE=/tmp/$SCRIPTNAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

VALIDATE(){
    if [$1 -ne 0]
    then
        echo -e "$2.. $R Failed $N"
    else
        echo -e "$2.. $G Successful $N" 
    fi   
}

if [$USERID -ne 0]
then
    echo "you don't have access, only root-user can access the file, try to login in as root-user"
    exit 1 # manually exits if error
else
    echo "You are super-user"
fi

#Copying mongo.repo to allow package installation
cp mongo.repo /etc/yum.repos.d/mongo.repo &>> $LOGFILE
VALIDATE $? "Copied Mongo Repo" 

dnf install mongodb-org -y &>> $LOGFILE
VALIDATE $? "Installing mongodb-org"

systemctl enable mongod &>> $LOGFILE
VALIDATE $? "Enabling MongoDB"

systemctl start mongod &>> $LOGFILE
VALIDATE $? "Start MongoDB"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf &>> $LOGFILE
VALIDATE $? "Remote Server Access"

systemctl restart mongod &>> $LOGFILE
VALIDATE $? "Restarting MongoDB"

sudo apt update &>>$LOGFILE
sudo apt install unzip curl -y &>>$LOGFILE
VALIDATE $? "Updating Package"

cd opt/
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" &>>$LOGFILE
VALIDATE $? "Downloading AWS CLI Installer"

unzip awscliv2.zip &>>$LOGFILE
VALIDATE $? "Unziping awscli"

sudo ./aws/install
VALIDATE $? "Running the install script"

aws --version &>>$LOGFILE
VALIDATE $? "Verifying aws cli"

chmod +x /home/ec2-user/lab-exercise/03-mongodb/mongodb.sh

#source ./mongobackup.sh #it is second way of calling other script.
nano mongobackup.sh

chmod +x /home/ec2-user/lab-exercise/03-mongodb/mongobackup.sh

crontab -e

# */2 * * * * /home/ec2-user/lab-exercise/03-mongodb/mongobackup.sh
# crontab -l --> List all currently scheduled cron jobs for the current user.


