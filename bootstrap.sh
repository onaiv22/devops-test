#! /bin/bash
cd /home/ubuntu
aws s3 cp s3://wipro/* .
sudo apt-get update
sudo apt-get install nodejs -y
sudo apt install npm -y
#npm test
npm start
