#!/usr/bin/env bash

# FILENAME:     c3subt-trint2pad.sh
# AUTHOR:       Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# DESCRIPTION:  Create txt file from srt file and copy txt to clipboard.

# Copyright © 2018 Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

# use strict - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail;
IFS=$'\n\t';

INPUT_FILENAME=$1;
OUTPUT_FILENAME=`echo $INPUT_FILENAME | sed 's/\.srt$/\.txt/g'`;

# generate txt from srt (SubRip) file
~/bin/pad_from_trint.py $INPUT_FILENAME > $OUTPUT_FILENAME;

# copy txt file to clipboard
xclip -i -selection c $OUTPUT_FILENAME;

