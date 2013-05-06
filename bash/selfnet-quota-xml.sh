#!/bin/bash

# This file is a bash script called "selfnet-quota-xml.sh".
# Copyright (C) 2013 Andreas Boesen
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
## Usage:       ./selfnet-quota-xml.sh 
## Abstract:    Shows the current quota.  
##              Tested with Debian Testing. 
## Date:        2012-12-12
## Version:     0.2
## Licence:     GPLv2

#http://www.selfnet.de/quota.xml

query=$(curl --silent http://www.selfnet.de/quota.xml);
lineCountOfQuery=$(echo "$query" | wc -l);

lineOfStartQuery=$(echo "$query" | grep -n "<quota>" | cut -d: -f1);
lineOfEndQuery=$(echo "$query" | grep -n "</quota>" | cut -d: -f1);


# error handling
isErrorLine=$(echo "$query" | grep -n "<error" | cut -d: -f1);

## Wenn ein Integer rauskommt gibts nen Fehler. There is an error if there is an integer.
if [[ $isErrorLine == [0-9]* ]]; then
      errorMsg="    ERROR: "$(echo "$query" | head -n $isErrorLine | tail -n 1 | sed -e 's/<error desc="/ /g' | sed -e 's/" \/>/ /g' | cut -c 3-);
      echo "$errorMsg";
      exit 1; 
fi

# <total />
totalLineNumber=$(echo "$query" | grep -n "<total" | cut -d: -f1);
total=$(echo "$query" | head -n $totalLineNumber | tail -n 1);
totalInBytes=$(echo "$total" | cut -b 15- | cut -d ' ' -f 1 | sed -e 's/"//g');
totalInGiBs=$(echo "$total" | cut -b 15- | cut -d ' ' -f 2 | sed -e 's/caption="//g');

# <used />
usedLineNumber=$(echo "$query" | grep -n "<used" | cut -d: -f1);
used=$(echo "$query" | head -n $usedLineNumber | tail -n 1); 
usedInBytes=$(echo "$used" | cut -b 15- | cut -d ' ' -f 1 | sed -e 's/"//g');
usedInGiBs=$(echo "$used" | cut -b 15- | cut -d ' ' -f 2 | sed -e 's/caption="//g');
usedInPercent=$( echo "$(echo "$used" | cut -b 15- | cut -d ' ' -f 4 | sed -e 's/percentage="//g' | sed -e 's/"//g' | cut -b -4)*100" | bc -l | cut -d. -f 1);

# <available />
availableLineNumber=$(echo "$query" | grep -n "<available" | cut -d: -f1);
available=$(echo "$query" | head -n $availableLineNumber | tail -n 1); 
availableInBytes=$(echo "$available" | cut -b 15- | cut -d ' ' -f 1 | sed -e 's/"//g');
availableInGiBs=$(echo "$available" | cut -b 15- | cut -d ' ' -f 2 | sed -e 's/caption="//g');
availableInPercent=$( echo "$(echo "$available" | cut -b 15- | cut -d ' ' -f 4 | sed -e 's/percentage="//g' | sed -e 's/"//g' | cut -b -4)*100" | bc -l | cut -d. -f 1);

# <color />
## not implemented yet ... :P 


# output
#echo -e "	You have used \033[1m$usedInGiBs""GiB\033[0m of \033[1m$totalInGiBs""GiB. 						\033[1m($usedInGiBs""GiB / $totalInGiBs""GiB)\033[0m	($usedInBytes bytes / $totalInBytes bytes)";
#echo -e "	This means that you used \033[1m$usedInPercent""%\033[0m and you have \033[1m$availableInPercent""%\033[0m left of your total Quota.		\033[1m($usedInPercent""% / $availableInPercent""%)\033[0m";
#echo -e "	You can still produce \033[1m$availableInGiBs""GiB\033[0m of traffic in this month.";

if [ -z "$1" ]; then 
   # default (used GiB / total GiB)
   echo $usedInGiBs " GiB / " $totalInGiBs" GiB";
elif [ "$1" == "-v" ] || [ "$1" == "--verbose" ]; then
   # -v or --help 
   echo -e "	You have used \033[1m$usedInGiBs""GiB\033[0m of \033[1m$totalInGiBs""GiB.
	\033[1m($usedInGiBs""GiB / $totalInGiBs""GiB)\033[0m	($usedInBytes bytes / $totalInBytes bytes)
				";
   echo -e "	This means that you used \033[1m$usedInPercent""%\033[0m and you have \033[1m$availableInPercent""%\033[0m left of your total Quota.
	\033[1m($usedInPercent""% / $availableInPercent""%)\033[0m
				";
   echo -e "	You can still produce \033[1m$availableInGiBs""GiB\033[0m of traffic in this month.";
else
   # give help if $1 is set
   echo "selfnet-quota-xml Bash Script (c)2013 by Andreas Boesen";
	echo "Licence: GNU GPL Version 2 - http://www.gnu.org/licenses/gpl-2.0.html";
	echo "";
	echo "usage: quota [-o|--option]";
	echo "-v --verbose			DE: Viele unnuetze Informationen.";
	echo "				EN: A lot of useless information.";
   echo "";
   echo "-h --help			DE: Diesen Text anzeigen.";
	echo "				EN: Display the text you are reading right now.";
	echo "";
fi












