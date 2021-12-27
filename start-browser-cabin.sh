#!/bin/bash

export DISPLAY=":0"

sleep 5

chromium-browser --window-position=0,0 --no-first-run --noerrdialogs --disable-infobars http://localhost:3000/signalk-reflections/ &

