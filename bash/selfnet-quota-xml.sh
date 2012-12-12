#!/bin/bash

#http://www.selfnet.de/quota.xml


query=$(curl --silent http://www.selfnet.de/quota.xml);
lineCountOfQuery=$(echo "$query" | wc -l);

lineOfStartQuery=$(echo "$query" | grep -n "<quota>" | cut -d: -f1);
lineOfEndQuery=$(echo "$query" | grep -n "</quota>" | cut -d: -f1);


# error handling
isErrorLine=$(echo "$query" | grep -n "<error" | cut -d: -f1);

if [ $(echo $isErrorLine | grep -q '^[0-9]\+$') ]; then
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
echo -e "	You have used \033[1m$usedInGiBs""GiB\033[0m of \033[1m$totalInGiBs""GiB. 						\033[1m($usedInGiBs""GiB / $totalInGiBs""GiB)\033[0m	($usedInBytes bytes / $totalInBytes bytes)";
echo -e "	This means that you used \033[1m$usedInPercent""%\033[0m and you have \033[1m$availableInPercent""%\033[0m left of your total Quota.		\033[1m($usedInPercent""% / $availableInPercent""%)\033[0m";
echo -e "	You can still produce \033[1m$availableInGiBs""GiB\033[0m of traffic in this month.";





