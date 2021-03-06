#!/bin/sh

#######################################################################
#                                                                     #
# This is a script that monitors Unbound DNS resolvers.               #
#                                                                     #
# The script uses unbound-control to check that Unbound is running,   #
# and to display the statistics as performace data.                   #
#                                                                     #
#                                                                     #
# Version 1.0 2018-09-04 Initial release                              #
#                                                                     #
# Licensed under the Apache License Version 2.0                       #
# Written by farid@joubbi.se                                          #
#                                                                     #
#######################################################################


unboundcontrol="/usr/bin/sudo /usr/sbin/unbound-control"

$unboundcontrol -q status
if [ "$?" != 0 ]; then
  echo "Unbound not running properly!"
exit 3
fi

echo "Unbound OK | " | tr -d '\n'
$unboundcontrol stats | grep -v thread | grep -v histogram | grep -v time. | sed 's/$/; /' | tr -d '\n'

