#!/bin/bash

#http://www.selfnet.de/quota.xml


query=$(curl --silent http://www.selfnet.de/quota.xml);
lineCountOfQuery=$(echo "$query" | wc -l);

lineOfStartQuery=$(echo "$query" | grep -n "<quota>" | cut -d: -f1);
lineOfEndQuery=$(echo "$query" | grep -n "</quota>" | cut -d: -f1);

isErrorLine=$(echo "$query" | grep -n "<error" | cut -d: -f1);

if [ $isErrorLine -eq 3 ]; then
   errorMsg=$(echo "$query" | head -n $isErrorLine | tail -n 1 | cut -f1 -d= );
   echo "$errorMsg";
   return 1; 
fi


echo "$lineOfEndQuery";



