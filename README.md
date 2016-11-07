# This repository is no longer maintained.

automated-facebook-voting
=========================

A script to automate voting for woobox.com contests. By changing user-agent and rotating IP addresses you are able to vote endlessly.

To run just: ./start_automated_voting.sh

Requirements
===
* openvpn 
* phantomjs
* tor

VPN Requirements
===
* Need to create a text file named vpnlist.txt that contains a list of all .ovpn files supported by your provider. Each line should be the path to a .ovpn file.
* .ovpn files must contain auth-user-pass option

TOR Requirements
===
* TOR needs to be running with control port enabled and configured with a password. 

Required File Edits
===
* phantomjs_vote.js - update actual_content_url and id_to_vote_for
* start_automated_voting.sh - update HOME_IP
* change_tor_identity.py - update TOR control port and password
