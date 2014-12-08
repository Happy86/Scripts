#!/bin/bash

# This file is a bash script called "fai-create-files.sh".
# Copyright (C) 2013 Andreas Boesen
# 
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; Version 2
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
## Usage:       ./fai-create-files.sh 
## Abstract:    Copies a folder/file structure from a given source
##              to a destination in your FAI config space using the
##              class you chose. 
##              Really convenient if you want to add a lot of files.
## Date:        2013-06-05
## Version:     0.1
## Licence:     GPLv2


## PLEASE CHANGE THE FOLLOWING VARS TO FIT YOUR TASK. :-) 

FAICLASS="WORKSTATION";
SOURCEDIR="./sourcefolder";
TARGETDIR="./targetfolder";




## DO NOT MODIFY BELOW HERE IF YOU JUST USE THE SCRIPT!
# aka logic ;-) 

FOLDER_CREATION_ARRAY=($(find $SOURCEDIR | cut -c $(echo "$SOURCEDIR" | wc -c)- | sed -e 's/^/./'));

for FOLDER_ITEM in ${FOLDER_CREATION_ARRAY[@]};
do
   mkdir -p $TARGETDIR/$FOLDER_ITEM;
   if [ "$(file "$SOURCEDIR/$FOLDER_ITEM" | rev | cut -c -9 | rev)" != "directory" ];
   then
      cp $SOURCEDIR/$FOLDER_ITEM $TARGETDIR/$FOLDER_ITEM/$FAICLASS;
   fi
done


