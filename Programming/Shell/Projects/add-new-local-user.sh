#!/bin/bash

# Take the requirements from add-local-user.sh C:\Users\nikit\Documents\Projects\shellclass\localusers

# Requirements
# The script executes with the super user root priveleges
if [[ "${UID}" -ne 0 ]]
then
	echo "Please execute the script with superuser root privileges."
	exit 1
fi

# The script nneds to give atleast one command line argument 
COMMAND_LINE_ARGUMENTS="${#}"
if [[ COMMAND_LINE_ARGUMENTS -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT].."
	exit 1
fi 

# Parsing the command line arguments
# Assigning the first parameter to the USER_NAME variable 
USER_NAME="${1}"

# The rest of the parameters are for the account comments
shift
COMMENT="${@}"

useradd -c "${COMMENT}" -m "${USER_NAME}"
# Check if the useradd command succeeded in creating the account
if [[ "${?}" -ne 0 ]]
then
	echo "Account creation failed!!"
	exit 1
else
	echo "Account creation succeeded!!"
fi

# Check if the password was generated successfuly
PASSWORD=$(date +%s%N | sha256sum | head -c48)
if [[ ${?} -ne 0 ]]
then 
	echo "Password generation failed!!"
	exit 1
else
	echo "Password generation successfull"
fi

# Assign the generated password to created user account
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
if [[ ${?} -ne 0 ]]
then
	echo "Account Creation Unsuccessfull"
	exit 1
else
	echo "Account creation successfull"
fi

# Initiate Password change on first login 
passwd -e ${USER_NAME}

# Extracting hostname value
HOST_NAME=$(hostname -s)
# Display new account information for user
echo "Created Username: ${USER_NAME}"
echo "Created Password: ${PASSWORD}"
echo "Created at host: ${HOST_NAME}"



