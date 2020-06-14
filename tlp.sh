#!/bin/sh

# Install TLP
sudo add-apt-repository ppa:linrunner/tlp
sudo apt-get -y update
sudo apt-get -y install tlp tlp-rdw

# Install acpi-call-dkms for newer thinkpads
sudo apt -y install acpi-call-dkms

# tlp service start and status
sudo tlp start 
sudo systemctl status tlp

# tlp stats
sudo tlp-stat    # display all power settings
sudo tlp-stat -b # display Linux battery information
sudo tlp-stat -c # display all tlp configurations
sudo tlp-stat -p # display Processor Data
sudo tlp-stat -s # display system information and tlp status
sudo tlp-stat -t # display Temperatures and Fan Speed of system
sudo tlp-stat -w # display any warnings

# tlp battery thresholds
sudo nano /etc/tlp.conf

# Uncomment folloings:
# START_CHARGE_THRESH_BAT0=75
# STOP_CHARGE_THRESH_BAT0=80

# START_CHARGE_THRESH_BAT1=75
# STOP_CHARGE_THRESH_BAT1=80


