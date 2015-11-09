#!/usr/bin/env bash

# FILENAME:     config.d-create-symlinks.sh
# AUTHOR:       Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# Description:  Set symlinks into ~/.ssh/ to ssh-keys and config files.

# Copyright © 2015 Andreas Boesen <andreas.boesen-AT-selfnet-NOSPAM-dot-de>
# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See http://www.wtfpl.net/ for more details.


# use strict - http://redsymbol.net/articles/unofficial-bash-strict-mode/
set -euo pipefail;
IFS=$'\n\t';


SCRIPTDIR="$( cd "$(dirname "$0")" ; pwd -P )";
KEYARRAY=( `ls -1 ${SCRIPTDIR}/keys/ | grep -vE '*.pub'` );


# Check if there are keypairs in the keys folder.
NUMBEROFKEYS="$( ls ${SCRIPTDIR}/keys/ | grep -vE '*.pub' | wc -w )";
if [ $NUMBEROFKEYS -eq 0 ]
then
    echo "ERROR: There are no keypairs in ${SCRIPTDIR}/keys/";
    exit 1;
fi


# Symlinks to SSH Config
echo "-- CREATING SYMLINKS FOR SSH CONFIG";
ln -v --force --symbolic $SCRIPTDIR/config.d ~/.ssh/;
ln -v --force --symbolic $SCRIPTDIR/config.d-gen.sh ~/.ssh/config.d-gen.sh;
echo " ";
echo " ";

 
# Symlinks to SSH Keys
echo "-- CREATING SYMLINKS FOR SSH-KEYS AND CHECKING THE PERMISSIONS";
for KEY in "${KEYARRAY[@]}"
do
    echo "---- CREATING SYMLINKS FOR ${KEY}";
    ln -v --force --symbolic $SCRIPTDIR/keys/$KEY ~/.ssh/$KEY;
    ln -v --force --symbolic $SCRIPTDIR/keys/${KEY}.pub ~/.ssh/${KEY}.pub;
    echo "---- CHECKING PERMISSIONS FOR ${KEY}";
    chmod -v 600 $SCRIPTDIR/keys/$KEY
    chmod -v 640 $SCRIPTDIR/keys/${KEY}.pub
    echo " ";
done

