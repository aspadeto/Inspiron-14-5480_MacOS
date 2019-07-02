#!/bin/sh

# Obtido em https://www.tonymacx86.com/threads/guide-native-power-management-for-laptops.175801/
#


sudo pmset -a hibernatemode 0
sudo rm -f /var/vm/sleepimage
sudo mkdir /var/vm/sleepimage # try to prevent update from re-enabling
sudo pmset -a standby 0
sudo pmset -a autopoweroff 0
