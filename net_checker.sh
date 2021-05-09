#!/bin/bash

interface=eth0
interval=$((SECONDS+15))
exit_flag=1
prev_second=0

while [ $exit_flag -ne 0 ]; do
    if [ $SECONDS -gt $prev_second ]; then
        prev_second=$SECONDS
        if [ $SECONDS -eq $interval ]; then
            if [ $(cat /sys/class/net/$interface/carrier) = 1 ]; then
                echo "Online at" $(date)
            elif [ $(cat /sys/class/net/$interface/carrier) = 0 ]; then
                echo "****Offline at" $(date) "*****"
            fi
            interval=$((SECONDS+15))
        fi
    fi
done
