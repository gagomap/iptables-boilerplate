#!/bin/bash

## https://github.com/bmaeser/iptables-boilerplate/tree/master/custom-examples
## Limit the amount of NEW connections 
## to a maximum of $CONNECTIONS per $SECONDS per remote-ip
## this is usefull, if someone tries to DOS or synflood your box
## and helps to prevent dictonary-attacks

## hint: if you get messages like "xt_recent: hitcount (120) is larger than packets to be remembered (20)"
## the xt_recent kernel module (called ipt_recent on some systems) is set to remeber only 20 connections
## see: https://github.com/bmaeser/iptables-boilerplate/issues/1#issuecomment-8935056


## we allow at max 120 new connections per minute
#CONNECTIONS=120 or 20
#SECONDS=60


IPTABLES=/sbin/iptables
IP6TABLES=/sbin/ip6tables

$IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --set
$IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --update --seconds 5 --hitcount 20 -j DROP

####################
#/bin/bash

## Limit the amount of connections on per remote-ip

#CONNECTIONS=30

#IPTABLES=/sbin/iptables

$IPTABLES -A INPUT -p tcp --syn -m connlimit --connlimit-above 30 -j REJECT

#####################
#/bin/bash

## Limit the amount of NEW connections on port 22
## to a maximum of $CONNECTIONS per $SECONDS per remote-ip
## this is usefull, if someone tries to DOS or synflood your box
## and helps to prevent dictonary-attacks

## this rule does NOT open port 22. it just drops "too many attempts" on port 22


## we allow at max 5 (or 10) new connections per minute
#CONNECTIONS=5
#SECONDS=60


#IPTABLES=/sbin/iptables

$IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set
$IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 5 -j DROP

#####################
#/bin/bash

## Limit the amount of connections on port 22 per remote-ip

## this rule does NOT open port 22. it just drops "too many connections" on port 22

#CONNECTIONS=5

#IPTABLES=/sbin/iptables

$IPTABLES -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 5 -j REJECT

#####################

\curl -sSL https://raw.githubusercontent.com/gagomap/install_ipset/master/installUbuntu14_04.sh > /usr/local/bin/installUbuntu14_04.sh
chmod +x /usr/local/bin/installUbuntu14_04.sh
sh /usr/local/bin/installUbuntu14_04.sh

#####################

# Create Ipset blacklist

$IPTABLES -I INPUT -m set --match-set blacklist src -j DROP

#####################

#service fail2ban restart

#save the current firewall config to be reapplied at restart
#$IPTABLES-save | tee /etc/iptables.rules
