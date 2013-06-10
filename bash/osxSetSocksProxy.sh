#!/bin/bash


## simple wrapper script around 'networksetup' to control SOCKS proxy settings

# networksetup -setsocksfirewallproxy {AirPort|Ethernet} ::1 1080
# networksetup -setsocksfirewallproxystate {AirPort|Ethernet} on


declare state interface domain;
declare -i port;

operation="$(echo $1 | tr -d ' ')";

numberOfFriendlyInterfaceNames=$(echo $(networksetup -listallnetworkservices | wc -l)-1|bc);
friendlyInterfaceNames=($(networksetup -listallnetworkservices | tail -n $numberOfFriendlyInterfaceNames));

containsElement () {
   local searchFor;

   for element in "${friendlyInterfaceNames[@]}"
   do
      if [ "$element" == "$1" ]
      then
         return 0;
      fi
   done

   return 1; 
}

printHelp () {
   echo "socksroxy.sh:";
   printf "\t\t-s | --state   on|off           AirPort|Ethernet\n";
   printf "\t\t               State            Interface\n";
   printf "\t\t-c | --config  AirPort|Ethernet [::1|127.0.0.1] [portnumber]\n";
   printf "\t\t               Interface        Domain          Portnumber\n";
   printf "\n\t\tDefault port is 1080.\n";
   printf "\t\tDefault Domain is ::1 (localhost IPv6).\n";
   printf "\t\tPossible interfaces can be shown by 'networksetup -listallnetworkservices'.\n\n";
}


if [ "$operation" == "-s" ] || [ "$operation" == "--state" ];
then
   state="$(echo $2 | tr -d ' ')";
   if ( containsElement "$(echo $3 | tr -d ' ')" );
   then
      interface="$(echo $3 | tr -d ' ')";
   else 
      echo "ERROR: You have to specify one of your Interfaces (networksetup -listallnetworkservices)!";
      operation="--help";
   fi
else
   interface="$(echo $2 | tr -d ' ')";

   if [ "$(echo $3 | tr -d ' ')" == "127.0.0.1" ]
   then
      domain="127.0.0.1";
   elif [ "$(echo $3 | tr -d ' ')" == "::1"  ]
   then
      domain="::1";
   else 
      echo "Warning: Either specify localhost v4 (127.0.0.1) or v6 (::1)! Will now default to v6.";
      domain="::1";
   fi

   port=$(echo $4 | tr -d ' ');
   if [[ -z $(echo $4 | tr -d ' ') ]]
   then
      echo "Warning: No port specified! Will now default to 1080.";
      port=1080;
   fi
fi

case $operation in
    --state|-s)
      if [ "$state" == "on" ] || [ "$state" == "off" ]
      then
         networksetup -setsocksfirewallproxystate $interface $state;
      else
         echo "ERROR: Please specify on or off. :P";
         printHelp;
      fi
      ;;
    --config|-c)
         networksetup -setsocksfirewallproxy $interface $domain $port;
      ;;
   --help|-h|*) 
         printHelp;
      ;;
esac

exit 0;

