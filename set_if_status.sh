#!/bin/bash

if [ $(id -u) -ne 0 ]; then
  echo -e "Need root privileges\nRun: sudo $0 <interface name> <action>"
  exit 1
fi

if [ $# -ne 2 ]; then
  echo -e "Usage: $0 <interface name> <action>\n$0 enp0s8 down"
  exit 1
elif [ "$2" == "up" ] || [ "$2" == "down" ]; then
  INTERFACE=$1
  ACTION=$2

  echo "Check interface exists"
  interfaces=$(ip -o link show | awk -F: '{print $2}' | tr -d ' ')

#  if_exists="false"
#  for i in "${interfaces[@]}"; do
#    if [ "$i" == "$INTERFACE" ]; then
#      if_exists="true"
#      found_if="$i"
#      breack
#    fi
#  done
  if [[ "$interfaces" =~ "$INTERFACE" ]]; then
    echo "Found interface $INTERFACE"
    ip link set $INTERFACE $ACTION
  else
    echo "No such interface"
    exit 1
  fi
else
  echo "Illegal action. Need 'up' or 'down' only"
  exit 1
fi
