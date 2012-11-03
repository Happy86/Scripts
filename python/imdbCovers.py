#------------------------------------------------------------------------------
# @FILENAME:      ./imdbCovers.py
# @AUTHOR:        Happy
# @DESCRIPTION:   Using imdbapi.com to get the URI of a movie poster 
#                 by providing the title and and year.
#                 Example: http://www.imdbapi.com/?t=True Grit&y=1969
# @LICENSE:       WTFPL - http://sam.zoy.org/wtfpl/
#------------------------------------------------------------------------------
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#                    Version 2, December 2004
#
# Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>
#
# Everyone is permitted to copy and distribute verbatim or modified
# copies of this license document, and changing it is allowed as long
# as the name is changed.
#
#            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
#   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION
#
#  0. You just DO WHAT THE FUCK YOU WANT TO. 
#------------------------------------------------------------------------------
#/* This program is free software. It comes without any warranty, to
# * the extent permitted by applicable law. You can redistribute it
# * and/or modify it under the terms of the Do What The Fuck You Want
# * To Public License, Version 2, as published by Sam Hocevar. See
# * http://sam.zoy.org/wtfpl/COPYING for more details. */ 
#------------------------------------------------------------------------------

import urllib, urllib2
import json


# Function to purge the unclean! Or the JSON stuff. We just want the 'Poster'.
def purgeJsonCrap(jsonCrap):
   lol = json.load(jsonCrap)
   return lol['Poster']

# Get the Cover URI
def gimmeCover(jahr, titel):
   # URI to the API Server.
   baseurl = "http://www.imdbapi.com/"
   # Creating the dictionary for 'urlencode()'.
   titeldic = dict()
   titeldic = {'t' : titel}
   titel = urllib.urlencode(titeldic)
   # Concatenating the parts.
   imguri = "?" + titel
   imguri += "&amp;" + "?y=" + str(jahr)
   uri = baseurl
   uri += imguri
   # Getting the JSON data.
   opener = urllib2.urlopen(uri)
   # Cleaning and returning.
   return purgeJsonCrap(opener)


# Examples :-)
# print "\n" + gimmeCover(1995, 'Hackers')
# print gimmeCover(1995, 'True Grit')

