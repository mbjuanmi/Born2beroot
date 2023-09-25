#!/bin/bash

echo "#Architecture: $(uname -a)"
echo "#CPU physical: $(grep 'physical id' /proc/cpuinfo | uniq | wc -l)"
echo "#vCPU : $(grep processor /proc/cpuinfo | uniq | wc -l)"
echo "#Memory Usage: $(free --mega | awk 'NR==2 {printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')"
echo "#Disk Usage: $(df -h | awk 'NR==4 {printf "%d/%.1fGB (%s)\n", $3*1024,$2,$5}')"
echo "#CPU Load: $(top -bn1 | grep '^%Cpu' | awk '{printf("%.1f%%"), $2 + $4}')"
echo "#Last boot: $(who -b | awk ' {print $3,$4}')"
echo "#LVM use: $(if [ $(lsblk | grep lvm | wc -l) -eq 0 ]; then echo no; else echo yes; fi)"
echo "#Connetions TCP: $(ss -s | grep TCP | awk 'NR==2 {printf "%d ESTABLISHED\n", $3}')"
echo "#User log: $(who | wc -l)"
echo "#Network: IP $(hostname -I)$(ip a | grep link/ether | awk '{printf "(%s)\n", $2}')"
echo "#Sudo: $(sudo grep -c 'COMMAND=' /var/log/auth.log)"
