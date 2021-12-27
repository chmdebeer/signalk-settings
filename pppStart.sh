#!/bin/bash

CHECK_IP=${CHECK_IP:-8.8.8.8}
PRIMARY_IF=${PRIMARY_IF:-eth0}

if ping -I "$PRIMARY_IF" -c1 "$CHECK_IP" &>/dev/null
then
  echo "eth0 is up"
else
  echo "eth0 is down"
  sleep 30
  sudo pon gprs
  sleep 15
  sudo route add -net 0.0.0.0 ppp0
fi
