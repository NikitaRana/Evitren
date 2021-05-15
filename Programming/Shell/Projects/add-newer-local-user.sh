#!/bin/bash

# Take the requirements from add-local-user.sh C:\Users\nikit\Documents\Projects\shellclass\localusers

# Requirements
# The script executes with the super user root priveleges and displaying the error on standard error (not in a file)
if [[ "${UID}" -ne 0 ]]
then
	echo "Please execute the script with superuser root privileges." >&2
	exit 1
fi

# The script nneds to give atleast one command line argument 
COMMAND_LINE_ARGUMENTS="${#}"
if [[ COMMAND_LINE_ARGUMENTS -lt 1 ]]
then
	echo "Usage: ${0} USER_NAME [COMMENT].." >&2
	exit 1
fi 

# Parsing the command line arguments
# Assigning the first parameter to the USER_NAME variable 
USER_NAME="${1}"

# The rest of the parameters are for the account comments
shift
COMMENT="${@}"

useradd -c "${COMMENT}" -m "${USER_NAME}" &> /dev/null
# Check if the useradd command succeeded in creating the account
if [[ "${?}" -ne 0 ]]
then
	echo "Account creation failed!!" >&2
	exit 1
fi

# Check if the password was generated successfuly
PASSWORD=$(date +%s%N | sha256sum | head -c48)
if [[ ${?} -ne 0 ]]
then 
	echo "Password generation failed!!" >&2
	exit 1
fi

# Assign the generated password to created user account
echo ${PASSWORD} | passwd --stdin ${USER_NAME} &> /dev/null
if [[ ${?} -ne 0 ]]
then
	echo "Account Creation Unsuccessfull" >&2
	exit 1
fi

# Initiate Password change on first login 
passwd -e ${USER_NAME} &> /dev/null

# Extracting hostname value
HOST_NAME=$(hostname -s)
# Display new account information for user
echo "Created Username: ${USER_NAME}"
echo "Created Password: ${PASSWORD}"
echo "Created at host: ${HOST_NAME}"
exit 0


