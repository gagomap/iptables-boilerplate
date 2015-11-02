#!/bin/bash
echo "Limit the amount of NEW connections " 

## https://github.com/bmaeser/iptables-boilerplate/tree/master/custom-examples
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

# We disable it, bescause ddos-deflate is better.
# $IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --set
# $IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --update --seconds 2 --hitcount 20 -j DROP

echo "############################################################"

# /bin/bash

echo "Limit the amount of connections on per remote-ip"

# CONNECTIONS=30

# IPTABLES=/sbin/iptables

# We disable it, bescause ddos-deflate is better.
# $IPTABLES -A INPUT -p tcp --syn -m connlimit --connlimit-above 60 -j REJECT

echo "############################################################"

#/bin/bash

echo "Limit the amount of NEW connections on port 22"
## to a maximum of $CONNECTIONS per $SECONDS per remote-ip
## this is usefull, if someone tries to DOS or synflood your box
## and helps to prevent dictonary-attacks

## this rule does NOT open port 22. it just drops "too many attempts" on port 22


## we allow at max 5 (or 10) new connections per minute
#CONNECTIONS=5
#SECONDS=60


#IPTABLES=/sbin/iptables

$IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set
$IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

echo "############################################################"

#/bin/bash

echo "Limit the amount of connections on port 22 per remote-ip"

## this rule does NOT open port 22. it just drops "too many connections" on port 22

# CONNECTIONS=5

# IPTABLES=/sbin/iptables

$IPTABLES -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 10 -j REJECT

echo "############################################################"

echo "Clone nginx spam and install ipset"

\curl -sSL https://raw.githubusercontent.com/gagomap/nginx_blacklists/master/autoblock.sh > /etc/cron.daily/autoblock.sh
chmod +x /etc/cron.daily/autoblock.sh

echo "############################################################"

echo "Install ipset"

\curl -sSL https://raw.githubusercontent.com/gagomap/install_ipset/master/installUbuntu14_04.sh > /usr/local/bin/installUbuntu14_04.sh
chmod +x /usr/local/bin/installUbuntu14_04.sh
sh /usr/local/bin/installUbuntu14_04.sh


echo "############################################################"

echo "Update fail2ban settings"

\curl -sSL https://raw.githubusercontent.com/gagomap/install_fail2ban/master/install_fail2ban.sh > /usr/local/bin/install_fail2ban.sh
chmod +x /usr/local/bin/install_fail2ban.sh
sh /usr/local/bin/install_fail2ban.sh

echo "############################################################"
echo "Create Ipset blacklist"

$IPTABLES -I INPUT -m set --match-set blacklist src -j DROP


echo "Start ddos-deflate service"

service ddos start

echo "############################################################"
# save the current firewall config to be reapplied at restart
# $IPTABLES-save | tee /etc/iptables.rules
echo "############################################################"