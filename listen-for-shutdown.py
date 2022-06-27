#!/usr/bin/env python

import RPi.GPIO as GPIO
import subprocess
import time

print("Set BPIO3 to hi and wait for button press")
GPIO.setmode(GPIO.BCM)
GPIO.setup(3, GPIO.IN, pull_up_down=GPIO.PUD_UP)

while (True):
  GPIO.wait_for_edge(3, GPIO.FALLING)
  time.sleep(1)
  if (GPIO.input(3) == 0):
    print("shutdown")
    subprocess.call(['shutdown', '-h', 'now'], shell=False)
    time.sleep(4)


