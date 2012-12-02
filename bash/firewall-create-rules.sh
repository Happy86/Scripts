#!/bin/bash 

# This file is a bash script called "firewall-create-rules.sh".
# Copyright (C) 2012 Andreas Boesen
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.

## Author:      Andreas Boesen
## E-Mail:      andreasb -at- NOSPAM DOT selfnet dot de
## Usage:       Create iptables and ip6tables rules in this script and
##              run it as a superuser to make the changes permanent.
## Abstract:    I wanted a simple way to block some services to be used from
##              other locations than localhost without using tools like
##              Shorewall. Tested with Debian Wheezy (Testing). 
## Date:        2012-10-30 
## Version:     0.2
## Licence:     GPLv2 
## Credits:     * Markus for the hint to use REJECT instead of DROP
##              * http://www.debian-administration.org/articles/445 
##              * http://serverfault.com/questions/247176/iptables-
##                only-allow-localhost-access
##              * http://www.cyberciti.biz/tips/linux-iptables-how-
##                to-flush-all-rules.html


## This part flushes all existing netfilter rules in the kernel. (hopefully)
# IPv4
iptables -F && iptables -X && iptables -t nat -F && iptables -t nat -X && iptables -t mangle -F && iptables -t mangle -X && iptables -P INPUT ACCEPT && iptables -P FORWARD ACCEPT && iptables -P OUTPUT ACCEPT 
# IPv6
ip6tables -F && ip6tables -X && ip6tables -t nat -F && ip6tables -t nat -X && ip6tables -t mangle -F && ip6tables -t mangle -X && ip6tables -P INPUT ACCEPT && ip6tables -P FORWARD ACCEPT && ip6tables -P OUTPUT ACCEPT

echo ""
echo ""
echo "All entries in the following list should be empty!"
iptables --list
ip6tables --list

## Create your IP Tables rules here. --> 
## INSTRUCTIONS:
### Make $PORTNUMBER reachable from localhost.
### ip[6]^*tables -A INPUT -i lo -p tcp --dport $PORTNUMBER -j ACCEPT
###
### Make $PORTNUMBER unreachable from outside. If you use DROP instead of REJECT others can see that you closed the port.
### ip[6]^*tables -A INPUT -p tcp --dport $PORTNUMBER -j REJECT

# 5900/tcp vino-server VNC :0 only available from localhost.
iptables -A INPUT -i lo -p tcp --dport 5900:5901 -j ACCEPT
iptables -A INPUT -p tcp --dport 5900:5901 -j REJECT
ip6tables -A INPUT -i lo -p tcp --dport 5900:5901 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 5900:5901 -j REJECT

# 5800/tcp vino-server vnc-http only available from localhost.
iptables -A INPUT -i lo -p tcp --dport 5800:5801 -j ACCEPT
iptables -A INPUT -p tcp --dport 5800:5801 -j REJECT
ip6tables -A INPUT -i lo -p tcp --dport 5800:5801 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 5800:5801 -j REJECT

# X11 
iptables -A INPUT -i lo -p tcp --dport 6001 -j ACCEPT
iptables -A INPUT -p tcp --dport 6001 -j REJECT
ip6tables -A INPUT -i lo -p tcp --dport 6001 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 6001 -j REJECT

## <-- IP Tables end here. 

echo ""
echo ""
echo "The rules in the following list are now made permanent!"
iptables --list
ip6tables --list
echo ""
echo ""

## Some scriptfoo to make it permanent ...
# Write rules into files. 
iptables-save > /etc/firewall.conf
ip6tables-save > /etc/firewall6.conf

# Make the rules permanent by writing them into if-up.d. 
echo '#!/bin/sh' > /etc/network/if-up.d/iptables
echo "iptables-restore < /etc/firewall.conf" >> /etc/network/if-up.d/iptables
chmod +x /etc/network/if-up.d/iptables

echo '#!/bin/sh' > /etc/network/if-up.d/ip6tables
echo "ip6tables-restore < /etc/firewall6.conf" >> /etc/network/if-up.d/ip6tables
chmod +x /etc/network/if-up.d/ip6tables



