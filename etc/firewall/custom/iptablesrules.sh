#!/bin/bash

echo "############################################################"

echo "Clone nginx spam blacklists"

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

echo "END"

echo "############################################################"