#!/bin/bash
echo "Limit the amount of NEW connections " 

## https://github.com/bmaeser/iptables-boilerplate/tree/master/custom-examples

## we allow at max 120 new connections per minute
#CONNECTIONS=120 or 20
#SECONDS=60

IPTABLES=/sbin/iptables
IP6TABLES=/sbin/ip6tables

# We disable it, bescause ddos-deflate is better.
# $IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --set
# $IPTABLES -A INPUT -p tcp -m conntrack --ctstate NEW -m recent --update --seconds 2 --hitcount 20 -j DROP

echo "############################################################"

echo "Limit the amount of connections on per remote-ip"

# /bin/bash

# CONNECTIONS=30

# IPTABLES=/sbin/iptables

# We disable it, bescause ddos-deflate is better.
# $IPTABLES -A INPUT -p tcp --syn -m connlimit --connlimit-above 60 -j REJECT

echo "############################################################"

echo "Limit the amount of NEW connections on port 22"

#/bin/bash

## this rule does NOT open port 22. it just drops "too many attempts" on port 22


## we allow at max 5 (or 10) new connections per minute
## CONNECTIONS=5
## SECONDS=60


## IPTABLES=/sbin/iptables
## We disable it, bescause fail2ban stop bruteforces and ddos port 22
## $IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --set
## $IPTABLES -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW -m recent --update --seconds 60 --hitcount 10 -j DROP

echo "############################################################"

echo "Limit the amount of connections on port 22 per remote-ip"

#/bin/bash

## this rule does NOT open port 22. it just drops "too many connections" on port 22

## CONNECTIONS=5

## IPTABLES=/sbin/iptables
## We disable it, bescause fail2ban stop bruteforces and ddos port 22
## $IPTABLES -A INPUT -p tcp --syn --dport 22 -m connlimit --connlimit-above 10 -j REJECT

echo "############################################################"

echo "Clone nginx spam"

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

echo "############################################################"

## echo "Start ddos-deflate service"

## service ddos restart

# save the current firewall config to be reapplied at restart
# $IPTABLES-save | tee /etc/iptables.rules
echo "############################################################"