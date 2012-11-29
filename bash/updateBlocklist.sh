#!/bin/bash

##
## Random URL: http://www.bigbuckbunny.org/index.php/download/
## 
## Licence: WTFPL http://sam.zoy.org/wtfpl/COPYING
## Have fun. 
## 

wgetpfad=$(which wget); 

## Wenns im gleichen Verzeichnis landen soll wie das Skript!
# PATH=$(dirname "$(readlink -e "$0")"); 

## Wenns in ~/.config/transmission-daemon/blocklists landen soll
PATH=$HOME"/.config/transmission-daemon/blocklists";

$wgetpfad -O $PATH/level1.gz "http://list.iblocklist.com/?list=bt_level1&fileformat=p2p&archiveformat=gz"  
$wgetpfad -O $PATH/level2.gz "http://list.iblocklist.com/?list=bt_level2&fileformat=p2p&archiveformat=gz"  
$wgetpfad -O $PATH/level3.gz "http://list.iblocklist.com/?list=bt_level3&fileformat=p2p&archiveformat=gz"  
$wgetpfad -O $PATH/bogon.gz "http://list.iblocklist.com/?list=bt_bogon&fileformat=p2p&archiveformat=gz"  
$wgetpfad -O $PATH/badpeers.gz "http://list.iblocklist.com/?list=bt_templist&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/primeThreat.gz "http://list.iblocklist.com/?list=ijfqtofzixtwayqovmxn&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/corporateIPRanges.gz "http://list.iblocklist.com/?list=ecqbsykllnadihkdirsh&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/businessISPs.gz "http://list.iblocklist.com/?list=jcjfaxgyyshvdbceroxf&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/blizzard.gz "http://list.iblocklist.com/?list=blizzard&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/ubisoft.gz "http://list.iblocklist.com/?list=ubisoft&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/nintendo.gz "http://list.iblocklist.com/?list=nintendo&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/activision.gz "http://list.iblocklist.com/?list=activision&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/sony.gz "http://list.iblocklist.com/?list=soe&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/lindenLab.gz "http://list.iblocklist.com/?list=lindenlab&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/ea.gz "http://list.iblocklist.com/?list=electronicarts&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/pandora.gz "http://list.iblocklist.com/?list=aevzidimyvwybzkletsg&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/squareEnix.gz "http://list.iblocklist.com/?list=squareenix&fileformat=p2p&archiveformat=gz" 
$wgetpfad -O $PATH/warner.gz "http://list.iblocklist.com/?list=roadrunner&fileformat=p2p&archiveformat=gz" 

echo;
echo "Komprimierte IP Blacklisten wurden heruntergeladen!"
echo;

/bin/gunzip -f $PATH/*.gz; 

echo; 
echo "Dateien wurden ausgepackt."; 
echo; 

/bin/rm -f $PATH/*.gz $PATH/*.bin

echo; 
echo "gz und bin Dateien aufgeraeumt. (rm -f *.gz *.bin)"; 
echo "Siehe $PATH"; 
echo "BITTE NICHT VERGESSEN DEN transmission-daemon NEU ZU STARTEN!!!"
echo; 


