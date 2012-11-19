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


# 1. Get html file and pipe to 'grep' (print lines matching a pattern).
# 2. Find line with the information which is starting with a unique 
#    <div> tag and pipe to 'cut'. 
# 3. Cut everything after the starting <div> tag and pipe that to 'sed' 
#    (stream editor). 
# 4. Find the html escape for a whitespace and replace (s or substitude) 
#    it with a real (non escaped) whitespace throughout the remaining 
#    (g) string and pipe the rest to cut.
# 5. Reverse the character order so that the closing </div> Tag is at 
#    the start (>vid/<)
# 6. Take all characters after the >vid/< (</div) with cut.
# 7. Reverse the character order so that everything is in order again. :-)  

curl --silent http://www.selfnet.de/quota/ | grep '<div style="position:relative; z-index:1; font-size:14pt; margin:3px">' | cut -b 72- | sed -e 's/&nbsp;/ /g' | rev | cut -b 7- | rev



