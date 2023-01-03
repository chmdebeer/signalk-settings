# OS
    sudo apt-get update
    sudo apt-get upgrade
    sudo apt-get dist-upgrade
    sudo reboot

# Clean up
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
    cd ~
    mkdir signalk
    cd signalk
    git clone ssh://chmdebeer@gmail.com@source.developers.google.com:2022/p/chmdebeer/r/signalk-settings

# Install
    cd ~/signalk/signalk-settings
    chmod 755 install.sh
    ./install.sh
