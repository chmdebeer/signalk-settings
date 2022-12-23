#!/bin/bash

export DISPLAY=":0"
python /home/pi/signalk-settings/map-xinput.py

sleep 5

chromium-browser --window-position=0,0    --user-data-dir="/home/pi/Documents/Profiles/0" --start-fullscreen --no-first-run --noerrdialogs --disable-infobars http://localhost:3000/signalk-reflections/#/port &
chromium-browser --window-position=1920,0 --user-data-dir="/home/pi/Documents/Profiles/1" --start-fullscreen --no-first-run --noerrdialogs --disable-infobars http://localhost:3000/signalk-reflections/#/starboard &

