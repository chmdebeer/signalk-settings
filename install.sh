echo "Permissions"
cd ~/signalk/signalk-settings
chmod 777 pi_gpio_init.sh
chmod 777 gpioStart.sh
chmod 777 pppStart.sh
chmod 777 start-browser-cabin.sh
chmod 777 start-browser.sh

echo "Start up"
sudo cat ~/signalk/signalk-settings/boot.config.txt > /boot/config.txt

echo "For Cabin"
sudo cat ~/signalk/signalk-settings/etc.rc.local > /etc/rc/local


echo "CAN Bus"
cd ~
sudo /sbin/ip link set can0 up type can bitrate 250000
sudo cat ~/signalk/signalk-settings/etc.network.interfaces > /etc/network/interfaces

echo "Utilities"
sudo apt-get install wiringpi
sudo apt-get install minicom
sudo apt-get install can-utils


echo "Node"
sudo rm -rf /usr/local/bin/node
sudo rm -rf /usr/local/bin/tsc
sudo rm -rf /usr/local/bin/npm
sudo rm -rf /usr/local/bin/npx
sudo rm -rf /usr/local/bin/lib/node_modules
sudo rm -rf /usr/local/lib/node_modules

sudo rm -rf /usr/local/bin/pm2
sudo rm -rf /usr/local/bin/pm2-dev
sudo rm -rf /usr/local/bin/pm2-docker
sudo rm -rf /usr/local/bin/pm2-runtime


cd ~
uname -m
wget https://nodejs.org/download/release/v18.19.1/node-v18.19.1-linux-armv7l.tar.xz
tar -xf node-v18.19.1-linux-armv7l.tar.xz
cd node-v18.19.1-linux-armv7l
sudo cp -R * /usr/local/

wget https://nodejs.org/download/release/v18.19.1/node-v18.19.1-linux-x64.tar.xz

sudo npm install -g npm@9.0

echo "Typescript"
cd ~
sudo npm install -g typescript

echo "Signalk"
cd ~/signalk
wget https://github.com/SignalK/signalk-server/archive/refs/tags/v2.6.0.zip
unzip v2.6.0.zip
mv signalk-server-2.6.0 signalk-server
cd signalk-server
npm install
npm run build:all

echo "Reflections"
cd ~/signalk/signalk-server
npm install --save signalk-reflections git+ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-reflections.git
npm install --save signalk-fuel-usage git+ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-fuel-usage.git

echo "For Cabin"
npm install --save signalk-gpio git+ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-gpio.git
npm install --save signalk-ds18b20 git+ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-ds18b20.git
echo "For Dashboard"
npm install --save signalk-gsm git+ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-gsm.git

echo "Modifications"
cp -r ~/signalk/signalk-settings/node_modules/* ~/signalk/signalk-server/node_modules/. 


echo "pm2"
sudo npm install -g pm2
pm2 start ecosystem.config.js
pm2 startup systemd

echo "execute the command and then"
echo "pm2 save"


# crontab
#    crontab -e

#    @reboot /home/pi/pppStart.sh &
#    @reboot sleep 30 && /home/pi/start-browser.sh
#    @reboot /home/pi/signalk-server-node/pppStart.sh &
#    @reboot /home/pi/signalk-server-node/gpioStart.sh &

@reboot sleep 30 && /home/boat/signalk/signalk-settings/start-browser.sh

@reboot sudo nohup /home/pi/ympd --webport 8181 1>/dev/null 2>&1 &
@reboot sleep 30 && /home/pi/signalk/signalk-settings/start-browser-cabin.sh

