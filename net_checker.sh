#!/usr/bin/env bash

interface="eth0"
interval=$SECONDS
exit_flag=0
prev_second=$((SECONDS-1))
loglocation="/config"
logfile="net_checker.log"

while [ $exit_flag -ne 1 ]; do                                                  #get a perpetual loop going
    if [ $SECONDS -gt $prev_second ]; then                                      #only consider doing something once a second
        prev_second=$SECONDS
        if [ $SECONDS -eq $interval ]; then                                     #do something on the configured interval
            if [ $(cat /sys/class/net/$interface/carrier) = 1 ]; then
                echo "Online at" $(date) | tee -a $loglocation"/"$logfile
            elif [ $(cat /sys/class/net/$interface/carrier) = 0 ]; then
                echo "****Offline at" $(date) "*****" | tee -a $loglocation"/"$logfile
                ping -4 -I $interface -c 1 8.8.8.8
            fi
            interval=$((SECONDS+$NET_CHECKER_INTERVAL))
        fi
    fi
done
