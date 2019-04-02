#!/bin/bash

# Richard Givens 
# Simple Port Scanner
# First Build Date 01/27/2019


# Verifies that either 0, 2, 3, or 5 arguments are passed
if [ "$#" -gt "5" ] || [ "$#" -eq "1" ] || [ "$#" -eq "4" ];
  then # Generates an error message
    echo "Usage: ./portscanner.sh [-t timeout] [<host> <startport> <stopport>],"
    exit
fi
#-----------------------------------------------------------------------------
# Function pingcheck checks to see if the host is live
function pingcheck
{
  ping=`ping -c 1 $host | grep bytes | wc -l`
  if [ "$ping" -gt 1 ]
  then
    echo "$host is up"
  else
    echo "$host is down, quitting"
    exit
  fi
}
#------------------------------------------------------------------------------
# Function portcheck loops through the ports, checking if each port in the
# range is open
function portcheck
{
  for ((counter=$startport; $counter<=$stopport; counter++))
  do
     if timeout $maxtime bash -c "echo >/dev/tcp/$host/$counter"
     then
        echo "$counter open"
     else
        echo "$counter closed"
      fi
  done
}
#-------------------------------------------------------------------------------
# Function tracksErase prompts the user to delete the bash history.
# Credit given to Red Team Field Manual by Ben Clark
function tracksErase
{
  echo "Press d and then ENTER to delete bash history, or any other key to exit."
  read choice
    if [[ $choice = d ]];
    then
      echo "" > ~/.bash_history   #clears the bash history file. Source: RTFM
      exit
    else
      exit
    fi
}
#------------------------------------------------------------------------------
# Tests to see if $1 is empty, sets a flag as a variable if so
if [ -z "$1" ]
then
  loopflag=1
elif [[ $1 = "-t" ]] && [[ -z $3 ]];
then
  loopflag=1
  maxtime=$2
else
  loopflag=0
fi
#-------------------------------------------------------------------------------
# If loopf is set to 1, then the application drops to interactive mode
while [ $loopflag = 1 ];
do
  echo "Please enter a hostname or website address."
    read host     # Prompting for user input and setting global variables
      if [ -z $host ]
      then
        echo "No hostname entered."
        tracksErase
        exit
    fi
    echo "Your hostname is $host, please enter your start port."
      read startport
    echo "Your starting port is $startport, please enter the stop port."
      read stopport
    echo "Your stop port is $stopport, running $maxtime seconds per port."
  pingcheck
  portcheck
done
#-----------------------------------------------------------------------------
# If the loopflag is set to 0, then the application drops to standard mode
while [ $loopflag = 0 ]; # I know you mentioned a single if, but couldn't get it to work right
  do
    if [ $1  = "-t" ]    # If the user passes -t as an argument
    then                 # Then these variables are set
      loopflag=2         # Setting the flag prevents an infinite loop
      maxtime=$2         # Length of scan in seconds per port
      host=$3            # The hostname
      startport=$4       # Starting port, begining of range for scan
      stopport=$5        # Ending port, end of range for scan
      echo "Default timeout value changed to $maxtime seconds."
    else                 # Otherwise the scanner uses these default values
      loopflag=2
      maxtime=2          # maxtime default value is 2 seconds
      host=$1
      startport=$2
      stopport=$3
      echo "Default timeout value is $maxtime seconds."
    fi
done
#-----------------------------------------------------------------------------
# Function calls
pingcheck
portcheck
tracksErase
