#!/usr/bin/env bash

# FILENAME:     config.d-gen.sh
# AUTHOR:       Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# Description:  Creates one ssh config file from multiple ones.

# Copyright © 2015 Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.


# use strict - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail;
IFS=$'\n\t';


# Check if symlink to config file directory is set (or at least a directory exists).
if [ ! -d ~/.ssh/config.d ]
then
    echo "ERROR: Symlink to config.d directory not found! Please run config.d-create-symlinks.sh";
    exit 1;
fi

# Check if there are config files.
NUMBEROFCONFFILES="$( ls config.d/ | wc -w )";
if [ $NUMBEROFCONFFILES -eq 0 ]
then
    echo "ERROR: There are no config files in the ~/.ssh/config.d directory!";
    exit 1;
fi


# if config-old file exists
# -> delete it and move config to config-old
# if no config-old file exists
# -> check if config exists and move it to config-old
if [ -f ~/.ssh/config-old ]
then
    if [ -f ~/.ssh/config ]
    then
        rm ~/.ssh/config-old;
        mv ~/.ssh/config ~/.ssh/config-old;
    fi
else
    if [ -f ~/.ssh/config ]
    then
        mv ~/.ssh/config ~/.ssh/config-old;
    fi
fi


# make sure only user can rw config files
echo "-- Setting permissions for config files in ~/.ssh/config.d/*";
chmod -v -R 600 ~/.ssh/config.d/*;
echo " ";

# create new config file
echo "-- Concatenating config files (in ~/.ssh/config.d/*) to one big ~/.ssh/config file.";
cat ~/.ssh/config.d/* > ~/.ssh/config;
echo 'cat ~/.ssh/config.d/* > ~/.ssh/config';
if [ ! -f ~/.ssh/config ]
then
    echo "ERROR: Could not create the ~/.ssh/config file.";
    echo "-- Trying to copy old config back:";
    mv -v ~/.ssh/config-old ~/.ssh/config;
    exit 1;
fi

# set correct file permissions for new ~/.ssh/config file
chmod -v 600 ~/.ssh/config;


echo " ";
echo "-- Success";

