#!/bin/bash

HOST=8.8.8.8

DATE=`date`
PINGRES=`ping -c 2 $HOST`
PLOSS=`echo $PINGRES : | grep -oP '\d+(?=% packet loss)'`
echo "$DATE : Loss Result : $PLOSS"

if [ "100" -eq "$PLOSS" ];
then
    echo "$DATE : Starting"
    sudo pon gprs
else
    echo "$DATE : Already running"
fi
