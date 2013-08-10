#!/bin/bash

HOME_IP="<put_ip_here>"

while [ 1 ]; do
  previp=""
  while read line
  do
          echo "Connecting to VPN: $line"
          ( openvpn """$line""" & ) > /dev/null 2>&1
          sleep 15
  
          vpncount=$(ps -ef | grep 'openvpn' | grep -v grep | wc -l)
          if [ $vpncount -le 0 ]; then
                  echo "VPN failed to start"
                  continue
          fi
  
          i=0
          ip=""
          START=`date +%s`
          while [ $(( $(date +%s) - 60 )) -lt $START ]; do
                  ip=$(curl http://geoip.hidemyass.com/ip/ 2>/dev/null)
                  if [ "$ip" != "" ]; then
                          if [ "$ip" == "$HOME_IP" ]; then
                                  echo "IP is not VPN address"
                                  ip=""
                                  sleep 10
                                  continue
                          fi
                          if [ "$previp" == "$ip" ]; then
                                  echo "Previous ip $previp is same as current ip $ip"
                                  ip=""
                                  sleep 10
                                  continue
                          fi
                          echo "Got new IP $ip"
                          previp=$ip
                  else
                          echo "No new IP address yet."
                          sleep 2
                          continue
                  fi
  
                  echo "Running script on VPN"
                  echo "Voting .."
                  timeout 60 phantomjs --load-images=false --web-security=false phantomjs_vote.js
  
                  echo "Killing VPN.."
                  killall -9 openvpn
  
                  echo "Changing TOR identity"
                  python change_tor_identity.py
                  sleep 10
  
                  echo "Running script on TOR"
                  echo "Voting .."
                  timeout 60 phantomjs --proxy-type=socks5 --proxy=127.0.0.1:9050 --load-images=false --web-security=false vote_theo.js
                  break
          done
  
          echo "Cleaning up.."
          killall -9 openvpn
  
          sleep 2
  
  done < vpnlist.txt

done
