#!/bin/bash

# This file is a bash script called "selfnet-quota.sh".
# Copyright (C) 2012 Andreas Boesen
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
## Usage:       ./selfnet-quota.sh 
## Abstract:    Shows the current quota.  
##              Tested with Debian Testing. 
## Date:        2012-11-04
## Version:     0.1
## Licence:     GPLv2 


curl --silent http://www.selfnet.de/quota/ | grep '<div style="position:relative; z-index:1; font-size:14pt; margin:3px">' | cut -b 72- | sed -e 's/&nbsp;/ /g' | cut -b 1-16



