#!/usr/bin/env bash

# FILENAME:     config.d-gen.sh
# AUTHOR:       Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# DESCRIPTION:  Put in Congress mp4 files and get m4a audio containers you
#               can throw at a transcription tool. Also it cuts away to your
#               hearts content.
#               This is just a simple script so I do not have to look up the
#               cli args for ffmpeg. :-)
# USAGE:        ./c3subt-vid2audio.sh 00:18 41:25 35c3-9599-eng-deu-Locked_up_science_hd.mp4
#               ./c3subt-vid2audio.sh startcut endcut video-file.mp4

# Copyright © 2015 Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.

# use strict - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail;
IFS=$'\n\t';

# configfoo
DEFAULT_AUDIOSTREAM="0:2"


# get args
START_TIMESTAMP=$1
END_TIMESTAMP=$2
INPUT_FILENAME=$3

OUTPUT_FILENAME=`echo $INPUT_FILENAME | sed 's/\.mp4$/\.m4a/g'`


# ffmpeg -i 35c3-9599-eng-deu-Locked_up_science_hd.mp4 -ss 00:18.0 -to 41:25 -vn -map 0:2 -c:a copy 35c3-9599-eng-deu-Locked_up_science_hd.m4a

ffmpeg -i $INPUT_FILENAME -ss $START_TIMESTAMP -to  $END_TIMESTAMP -vn -map $DEFAULT_AUDIOSTREAM -c:a copy $OUTPUT_FILENAME

