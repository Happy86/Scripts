#!/bin/bash 

# This file is a bash script called "aptitude-updates.sh".
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
## Usage:       Create a cronjob as root where you run this script as 
##              often as you want (e.g.: every day at 18 o' clock). 
## Abstract:    I wrote this before I heared about apticron. :-P 
##              Tested with Debian Testing. 
## Date:        2012-11-03 
## Version:     0.1
## Licence:     GPLv2 

basepath="/path/to/script/folder/"
tempfile="aptitude-updates.temp"
emailAddress="user@domain.tld"
packNumber=$(apt-show-versions -u | wc -c);
maxPack=2

echo "####################################################" > $basepath/$tempfile
echo "# List of current available updates on $(hostname). :-)  #" >> $basepath/$tempfile
echo "####################################################\n" >> $basepath/$tempfile

echo "## $(date)" >> $basepath/$tempfile

echo "# aptitude update" >> $basepath/$tempfile
echo "$(aptitude update)" >> $basepath/$tempfile
echo "\n\n# aptitude -s full-upgrade" >> $basepath/$tempfile
echo "$(aptitude -s full-upgrade)" >> $basepath/$tempfile
echo "\n\n$(apt-show-versions -u)" >> $basepath/$tempfile


if [ $packNumber -gt $maxPack ]; then
   ## Es gibt Updates
   mail -s "[$(hostname)][aptitude-report] $(date)" $emailAddress < $basepath/$tempfile
else
   ## Es gibt keine Updates
   # mail -s "[erdos][aptitude-report] $(date)" $emailAddress < $basepath/$tempfile
   # echo "keine mail"
   # mail -s "[erdos][aptitude-report] $(date)" $emailAddress < $basepath/$tempfile
   echo "nothing ... do not send email ;-)"
fi

