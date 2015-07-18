<?php
/*
 * Inspiriert von:   http://checkip.dyndns.org/index.html
 * Ausgabeformat:    <html><head><title>Current IP Check</title></head><body>Current IP Address: 10.x.y.z</body></html>
 * Grund:            Get to know your IP. :P
 * Lizenzbla/Autor:  Ich stelle dieses PHP Skript unter die WTFPL
 *                   Bei problemen koennt ihr euch auf Google melden.
 *                   (WTFPL) 2012 Happy
 */

/* This program is free software. It comes without any warranty, to
 * the extent permitted by applicable law. You can redistribute it
 * and/or modify it under the terms of the Do What The Fuck You Want
 * To Public License, Version 2, as published by Sam Hocevar. See
 * http://sam.zoy.org/wtfpl/COPYING for more details. */




// Init vars with NULL pointer.
$userIP = null;
$outStream = null;

// Finding out your IP Address.
if (!isset($_SERVER['HTTP_X_FORWARDED_FOR'])) {
   $userIP = $_SERVER['REMOTE_ADDR'];
} else {
   $userIP = $_SERVER['HTTP_X_FORWARDED_FOR'];
}

// IP Address could not be found. Use mana potion. ... 0.o
if ($userIP == null) {
   die("Try again later.");
} else {
   // Make sure nobody has injected something strange! If so -> die!!!
   if(!filter_var($userIP, FILTER_VALIDATE_IP)){
      die("ARRRRGH!");
   }

   // Everything is fine. Create outStream.
   $outStream = "<html><head><title>Current IP Check</title></head><body>Current IP Address: ".$userIP."</body></html>";
}

// Print out result. YEAH ... EPIC SUCCESS!!!
echo $outStream;

?>
