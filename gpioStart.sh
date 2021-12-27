#!/bin/bash

gpio -g write 5 1
gpio -g write 6 1

gpio -g write 12 1
gpio -g write 22 1
gpio -g write 26 1
gpio -g write 27 1

gpio -g write 18 0
gpio -g write 13 0
gpio -g write 23 0
gpio -g write 24 0

gpio -g mode 5 out
gpio -g mode 6 out

gpio -g mode 12 out
gpio -g mode 22 out
gpio -g mode 26 out
gpio -g mode 27 out

gpio -g mode 18 out
gpio -g mode 13 out
gpio -g mode 23 out
gpio -g mode 24 out
