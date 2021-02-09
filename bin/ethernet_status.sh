#!/bin/bash

echo -e "%{F#000000} %{F#000000}$(/usr/sbin/ifconfig eth0 2>/dev/null| grep "inet " | awk '{print $2}')%{u-}"
