REM 
REM @author:   (c) >/< 2003 by Johannes (at Selfnet.de)
REM @about:    This script was implemented by Johannes for Andreas who 
REM            wanted to drain a notebook battery using Windows NT 6.1.
REM @licence:  "THE BEER-WARE LICENSE" (Revision 42):
REM            As long as you retain this notice you can do whatever 
REM            you want with this stuff. If we meet some day, and you think
REM            this stuff is worth it, you can buy me (Johannes) or Selfnet
REM            ClubMate or a beer in return.
REM 


@echo off

REM color z.B. 0A oder 0D
color 0A

REM while(true)
:a
for %%I in (*.*) do type %%I
goto a

