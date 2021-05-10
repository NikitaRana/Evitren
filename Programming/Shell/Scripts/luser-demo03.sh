#!/bin/bash

# Display the UID username of the user executing the script 
# Display if the user is a vagrant user or not

#Pseudocode

# Display the UID 
echo "You UID is ${UID}"

# Only display if the UID does not match 1000
UID_TO_TEST_FOR='1000' #dry run concept being applied here
if [[ "${UID}" -ne "${UID_TO_TEST_FOR}" ]]
then
	echo "Your UID ${UID} is not same as stored UID ${UID_TO_TEST_FOR}"
	exit 1  
# we specific the exit status as 1 (non-zero)  because the script does not execute successfully towards the bottom of the script
# Had the script executed successfully, the exit status would have been 0 

else
	echo "You UID ${UID} is same as stored UID ${UID_TO_TEST_FOR}"
fi

# Display the username 
USERNAME=$(id -un)

# Tests if the username command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "The id command did not execute successfully. The exit status of the command was ${USERNAME}"
	exit 1
else
	echo "The id command ran successfully and the exit status is zero which is ${USERNAME}"
fi

# ? - special variable in shell built in that is used to stored the exit status of the most recently executed command which in this case is USERNAME

#You can use a string test conditional
USERNAME_TO_TEST_FOR='vagrant'

if [[ "${USERNAME}" = "${USERNAME_TO_TEST_FOR}" ]]
then	
	echo "Your username matched ${USERNAME_TO_TEST_FOR}"
fi

#you can either use -eq or = 
#when we use == that is used for pattern matching 

# Test for != (not equal) for the string 
if [[ "${USERNAME}" != "${USERNAME_TO_TEST_FOR}" ]]
then
	echo "Your username did not match ${USERNAME_TO_TEST_FOR}"
	exit 1
else
	echo "Your username matched ${USERNAME_TO_TEST__FOR}"
fi

#Note: if you do not specify the exit status then, the script will assume the exit status of the last executed command as the final exit status. 























