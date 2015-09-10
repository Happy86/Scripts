#!/usr/bin/env perl

# AUTHOR:                   Andreas Boesen <andreasb@selfnet.de>
# FILENAME:                 generate-secure-password-hash.pl
# REIMPLEMENTATION FROM:    http://techbl.org/?p=59
# LICENSE:                  WTFPLv2
# DATE:                     2015-09-09

# This work is free. You can redistribute it and/or modify it under the
# terms of the Do What The Fuck You Want To Public License, Version 2,
# as published by Sam Hocevar. See the COPYING file for more details.

# Doku:
# * Reading Passwords
#  ** http://docstore.mik.ua/orelly/perl/cookbook/ch15_11.htm
# * crypt perldoc
#  ** http://perldoc.perl.org/functions/crypt.html
# * ReadMode (ReadKey)
#  ** http://search.cpan.org/~jstowe/TermReadKey-2.33/ReadKey.pm
#  ** cpan install Term::ReadKey

# CHANGELOG:
# * 2015-09-10 - translate all the comments
# * 2015-08-20 - fix: remove trailing \n (s/\n//g) from password (before the password including \n was also hashed)
# * 2015-08-18 - initial release

use warnings;
use strict;


use Term::ReadKey;


ReadMode('noecho');             # Make console input invisible!
print ("Password: ");
my ($password) = ReadLine(0);   # Read in the password.
$password =~ s/\n//g;           # Remove the newline from the end of the password.
print ("\n");

$password = '{CRYPT}'.crypt($password,"\$6\$".function_generate_salt()."\$");
print ($password);
print ("\n");

ReadMode('normal');             # Make console input visible again!


# Function: Generate salt string (16 characters)
sub function_generate_salt
{
    our (@chars) = (0..9, 'A'..'Z', 'a'..'z', '.', '/');
    our ($salt) = "";

    for (our ($salt_length) = 0; $salt_length < 16; $salt_length++)
    {
        $salt .= $chars[rand @chars];
    }

    return ($salt);
}



