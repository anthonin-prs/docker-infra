#!/bin/bash
if [ $# -ne 2 ]
  then
    echo "Missing arguments, usage:"
    echo "  sudo ./seed.sh Hostname IP"
    exit 1
fi
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root, usage:"
   echo "  sudo ./seed.sh Hostname IP"
   exit 1
fi

hostname=$1
host_ip=$2

sudo apt update > /dev/null 2>&1
sed -i "s/Ebenolt-Template/$hostname/g" /etc/hosts
sed -i "s/Ebenolt-Template/$hostname/g" /etc/hostname
ip_block_1=$(echo $host_ip | awk -F. '{print $1}')
ip_block_2=$(echo $host_ip | awk -F. '{print $2}')
ip_block_3=$(echo $host_ip | awk -F. '{print $3}')
ip_block_4=$(echo $host_ip | awk -F. '{print $4}')

# IP Address
sed -i "s/192.168.10.199/192.168.$ip_block_3.$ip_block_4/g" /etc/network/interfaces
# Gateway + DNS
sed -i "s/192.168.10.1/192.168.$ip_block_3.1/g" /etc/network/interfaces

