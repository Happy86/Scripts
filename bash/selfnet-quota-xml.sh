#!/bin/bash

#http://www.selfnet.de/quota.xml


query=$(curl --silent http://www.selfnet.de/quota.xml);
quotaLine=$(echo $query | cut -b 47-);

# Total
total=${"total"%:*};
echo $total;



