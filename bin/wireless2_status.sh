#!/bin/bash

echo -e " $(/usr/sbin/ifconfig wlan0 2>/dev/null| grep "inet " | awk '{print $2}')%{u-}"
