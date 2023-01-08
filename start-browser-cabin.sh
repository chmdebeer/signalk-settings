#!/bin/bash

export DISPLAY=":0"

sleep 5

chromium-browser --window-position=0,0 --no-first-run --noerrdialogs --start-fullscreen --noerrors --disable-session-crashed-bubble --disable-infobars http://localhost:3000/signalk-reflections/#/navigation &

