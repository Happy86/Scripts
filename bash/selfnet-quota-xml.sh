#!/bin/bash

#http://www.selfnet.de/quota.xml


query=$(curl --silent http://www.selfnet.de/quota.xml);
lineCountOfQuery=$(echo "$query" | wc -l);

lineOfStartQuery=$(echo "$query" | grep -n "<quota>" | cut -d: -f1);
lineOfEndQuery=$(echo "$query" | grep -n "</quota>" | cut -d: -f1);

isErrorLine=$(echo "$query" | grep -n "<error" | cut -d: -f1);

if [ $isErrorLine -eq 3 ]; then
   errorMsg="    ERROR: "$(echo "$query" | head -n $isErrorLine | tail -n 1 | sed -e 's/<error desc="/ /g' | sed -e 's/" \/>/ /g' | cut -c 3-);
   echo "$errorMsg";
   exit 1; 
fi

totalLineNumber	=$(echo "$query" | grep -n "<total" | cut -d: -f1);
total		=$(echo "$query" | head -n $totalLineNumber | tail -n 1);
totalInBytes	=$(echo "$total" | cut -b 15-);

echo "$totalInBytes";




