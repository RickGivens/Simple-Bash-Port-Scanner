Simple Bash Port Scanner
Richard Givens
01/27/2019

FILENAME
	portscanner.sh

USAGE
	./portscanner.sh [-t timeout] [<host> <startport> <stopport>]

DESCRIPTION

./porscanner.sh is a tool designed to test whether a host is live, and then test a range of ports 		
individually to detect whether they are open or closed. An option exists at the end of the program for the use to delete the contents of
~/.bash_history as the program exits.

The application consists of several parts: 

	The user's input is validated against acceptable paramaters, noted in USAGE, outputs an error message detailing the USAGE, and then 
  exits.

	If the user entered the correct parameters, ./portscanner.sh then tests for certain inputs. If the user entered no arguments in the 
  command execution, or if the user enterered the arguments for a timeout, but no host or port range, then the application will drop 
  into interactive mode, prompting the user to enter a host, starting port, and stopping port. The application will then output the
  desired timeout (entered by the 	user, or a default of 2 seconds), target host status (Up or Down), starting port and stopping port 
  (Open or Closed). After looping through the inputs and outputs once, the application will prompt the user to input additional arguments
  to scan another host, exiting if the user hits ENTER with no input.

	If the arguments for host and port range are included, the application will run unguided, accepting the arguments for the timeout, 
  host, and port range and outputting the desired timeout (entered by the user, or a default of 2 seconds), target host status 
  (Up or Down), starting port and stopping port (Open or Closed).

	In all cases, the user will be prompted to either delete contents of the ~/.bash_history, or exit the program without modifying the 
  contents in any way.


COMMAND LINE OPTIONS

	-t 	Sets the timeout flag, and requires the user to enter a number representing the number of seconds the user wishes the application 
  to scan each port. The time of the scan is presented by this number per each individual port. Example, -t 10 means a scan time of 10 
  seconds per port in the range of ports

	timeout	Represents the number of seconds the user enters immediately following the -t argument

	host	The target of the scan, represented by either a standard web address, or URL. If an erroneous host is entered, the program will 
  output that the host is down, and will exit the application

	startport	Beginning of the range of ports the application will scan. Represented by a number
	
	stopport	End of the range of ports the application will scan. Represented by a number

INPUT FILE FORMAT

	To use a file as input for the command arguments, the user must select a .txt file with the contents in the following format:
	
	host
	startport
	stopport
	(repeat the lables as needed for the total number of hosts scanned, so n hosts means repeating the above lables n times each)

KNOWN BUGS AND LIMITATIONS

	Currently there is no validation to prevent the user from entering a startport argument as a number larger than the stopport argument. Presumably if the port range is reversed (ie startport 80 stopport 75) the 		program will throw an error message, but this has not been tested. The next iteration of this application 		will include port range validation with the following logic: If startport > stopport, then <error message> 		and exit the application.

ADDITIONAL NOTES
	
	The application uses code examples from Coding for Penetration Testers by Jason Andress and Ryan Linn, as well as utilizing 
  the ~/.bash_history script from page 7 of the Red Team Field Manual by Ben Clark.
