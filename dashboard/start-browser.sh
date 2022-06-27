#!/bin/bash

export DISPLAY=":0"
python map-xinput.py

sleep 5

chromium-browser --window-position=0,0    --user-data-dir="/home/pi/Documents/Profiles/0" --no-first-run --noerrdialogs --disable-infobars http://localhost:3000/signalk-reflections/#/1/1 &
chromium-browser --window-position=1920,0 --user-data-dir="/home/pi/Documents/Profiles/1" --no-first-run --noerrdialogs --disable-infobars http://localhost:3000/signalk-reflections/#/1/2 &

