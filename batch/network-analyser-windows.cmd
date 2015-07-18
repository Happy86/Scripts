@REM FILENAME:		./network-analyser-windows.cmd
@REM AUTHOR:		Andreas Boesen <andreas.boesen-AT-selfnet-DOT-de>
@REM VERSION:		v0.01
@REM DATE:			2014-12-24
@REM DESCRIPTION:	Acquires the network settings, ping/traceroute to
@REM 				various destinations and echoes the information into
@REM				a text file.

@echo ############ > selfnet-debug-information.txt
@echo DEBUG OUTPUT >> selfnet-debug-information.txt
@echo ############ >> selfnet-debug-information.txt

@echo -------------------------------------------------------------------
@echo This script will take a while to get all the information
@echo that is needed by Selfnet to "maybe" identify, locate and
@echo hopefully solve the problem. 
@echo -------------------------------------------------------------------
@echo While waiting for this to finish you should treat yourself
@echo with a refreshing beverage. :-)
@echo -------------------------------------------------------------------
@echo The command prompt window will close as soon as it's done.
@echo After that you can send us the file "selfnet-debug-information.txt"
@echo which is located in the same folder where this script resides.
@echo -------------------------------------------------------------------

@echo _ >> selfnet-debug-information.txt
@echo ## ipconfig /all >> selfnet-debug-information.txt
@echo Test 1/7
ipconfig /all >> selfnet-debug-information.txt

@echo _ >> selfnet-debug-information.txt
@echo _ >> selfnet-debug-information.txt
@echo ## PING >> selfnet-debug-information.txt
@echo # ping 8.8.8.8 >> selfnet-debug-information.txt
@echo Test 2/7
ping 8.8.8.8 >> selfnet-debug-information.txt

@echo _ >> selfnet-debug-information.txt
@echo # ping www.selfnet.de >> selfnet-debug-information.txt
@echo Test 3/7
ping www.selfnet.de >> selfnet-debug-information.txt

@echo _>> selfnet-debug-information.txt
@echo # ping www.heise.de >> selfnet-debug-information.txt
@echo Test 4/7
ping www.heise.de >> selfnet-debug-information.txt


@echo _ >> selfnet-debug-information.txt
@echo _ >> selfnet-debug-information.txt
@echo ## tracert (traceroute) >> selfnet-debug-information.txt
@echo # traceroute 8.8.8.8 >> selfnet-debug-information.txt
@echo Test 5/7
tracert 8.8.8.8 >> selfnet-debug-information.txt

@echo _ >> selfnet-debug-information.txt
@echo # tracert www.selfnet.de >> selfnet-debug-information.txt
@echo Test 6/7
tracert www.selfnet.de >> selfnet-debug-information.txt

@echo _ >> selfnet-debug-information.txt
@echo # tracert www.heise.de >> selfnet-debug-information.txt
@echo Test 7/7
tracert www.heise.de >> selfnet-debug-information.txt

