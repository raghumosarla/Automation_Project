#!/usr/bin/env bash

export filename=raghu-httpd-logs-$(date '+%d%m%Y-%H%M%S').tar
export hostname=inventory.html

## checking packages for upgrades 

sudo apt-get update -y

## checking apache2 installed 
which apache2
RETURN=$?

if [ $RETURN == 0 ]; then
    echo "apache2 is already installed"
else
    sudo apt-get install apache2
fi

## checking aws installed 
which aws
RETURN=$?

if [ $RETURN == 0 ]; then
    echo "aws is already installed"
else
    sudo apt-get install awscli
fi

## start apache2
## enable apache2
## status apache2


RETURN=`sudo service apache2 status | grep -i running | wc -l`

if [ $RETURN == 1 ]; then
    echo "apache2 is already Running!"
    sudo service apache2 enable
else
    sudo service apache2 start
    sudo service apache2 enable
fi




cd /tmp/
tar cvf ${filename} /var/log/apache2/access.log

## #archiving log files from tmp to S3 bucket

aws s3 cp /tmp/$filename s3://upgrad-raghu


