# OS
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade
    sudo reboot

sudo apt-get clean
sudo apt update
sudo apt dist-upgrade -y
sudo apt autoremove -y
sudo apt autoclean


# Raspberry pi config
    sudo raspi-config

> Activate SSH, Serial, SPI, VNC, 1 Wire , disable boot serial

> Disable Screen blanking

# Add SSH keys
    ssh-keygen -t rsa -C "chmdebeer@gmail.com"
    vi /home/pi/.ssh/id_rsa.pub

# Get Settings
    git clone ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-settings

    cd signalk-settings
    chmod 777 pi_gpio_init.sh
    chmod 777 gpioStart.sh
    chmod 777 pppStart.sh
    chmod 777 start-browser-cabin.sh
    chmod 777 start-browser-dashboard.sh

    sudo cp boot.config.txt /boot/config.txt
    sudo cp etc.rc.local /etc/rc.local

# Utilities
    sudo apt-get install wiringpi
    sudo apt-get install minicom

> Check wire in setup

    ls /sys/bus/w1/devices/
    cat /sys/bus/w1/devices/28-xxxx/w1_slave

> Check modem

    minicom -D /dev/serial0

# Node
    uname -m

    wget https://nodejs.org/download/release/v14.18.2/node-v14.18.2-linux-armv7l.tar.xz
    tar -xf node-v14.18.2-linux-armv7l.tar.xz
    cd node-v14.18.2-linux-armv7l
    sudo cp -R * /usr/local/


# CAN Bus

    sudo /sbin/ip link set can0 up type can bitrate 250000

    sudo nano /etc/network/interfaces

> Add following lines

    auto can0
      iface can0 inet manual
      pre-up /sbin/ip link set can0 type can bitrate 250000
      up /sbin/ifconfig can0 up
      down /sbin/ifconfig can0 down

    auto ppp0
      iface ppp0 inet ppp
      provider gprs
      post-up echo "ppp0 is online"

    ip -details -statistics link show can0

> Download CAN test programs:

    sudo apt-get install can-utils

# Get Signalk
     wget https://github.com/SignalK/signalk-server/archive/refs/tags/v1.39.0.zip

    cp signalk-settings/ecosystem.config.js signalk-server/ecosystem.config.js

> Add package.json from settings to signalk
    sudo npm install -g typescript
    npm install
    npm run build

#pm2
    sudo npm install -g pm2
    pm2 start ecosystem.config.js
    pm2 startup systemd

> execute the command

    pm2 save


# RaspAP
curl -sL https://install.raspap.com | bash

Connect with:
  IP address: 10.3.141.1
  Username: admin
  Password: secret

sudo systemctl disable raspapd.service
sudo wpa_supplicant -B -Dnl80211,wext -c/etc/wpa_supplicant/wpa_supplicant.conf -iwlan0

# PPP
    sudo apt-get install ppp
    sudo su
    cd /etc/ppp/peers
    cp provider gprs
    nano gprs

    Replace with etc.ppp.peers.gprs

> Start with:

    sudo pppd call gprs

> verify with

    cat /var/log/syslog | grep pppd

nano ~/pppStart.sh
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

==========
#!/bin/bash
route_found=$(/sbin/route -n | /bin/grep -c ^0.0.0.0)
ppp_on=$(/sbin/ifconfig | /bin/grep -c ppp0)
if [ $route_found -eq 0 ] && [ $ppp_on -eq 1 ]
  then /sbin/route add default ppp0
fi
===================



chmod +x pppStart.sh
chmod +x gpioStart.sh

# crontab
    crontab -e

    @reboot /home/pi/pppStart.sh &
    @reboot sleep 30 && /home/pi/start-browser.sh
    @reboot /home/pi/signalk-server-node/pppStart.sh &
    @reboot /home/pi/signalk-server-node/gpioStart.sh &


see https://gist.github.com/Apsu/5021255 for future



sudo apt install mpd
sudo apt-get install alsa-utils
sudo apt-get install mpc
wget https://ympd.org/downloads/ympd-1.2.3-armhf.tar.bz2
tar -xvf ympd-1.2.3-armhf.tar.bz2

sudo ln -s /media/pi/USB\ DISK/ /var/lib/mpd/music/usb
sudo nano /etc/mpd.conf
sudo systemctl restart mpd
pmc play
sudo ./ympd --webport 8181





# Desktop Icon
    cp signalk-settings/reflections.desktop Desktop/reflections.desktop

# Starting
    DEBUG=signalk-server:put,signalk-reflections,signalk-gpio bin/signalk-server

    DEBUG=signalk-server:put,signalk-reflections bin/signalk-server

    SIGNALK_NODE_CONFIG_DIR=/home/pi/signalk-settings/.signalk DEBUG=signalk-gsm bin/signalk-server

    node bin\signalk-server -s settings/n2k-from-file-settings.json

# Disable screen saver
    sudo nano /etc/lightdm/lightdm.conf

    xserver-command=X -s 0 -p 0 -dpms
    #
    # XDMCP Server configuration

    sudo apt install xscreensaver
