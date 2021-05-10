#!/bin/bash

# This script creates an account on the local system
# You will be prompted for the account name and password


# Ask for the username
read -p 'Enter Username to create: ' USER_NAME

# Ask for the real name
read -p 'Enter your real name: ' COMMENT

# Ask for the password
read -p 'Enter a new password: ' PASSWORD


# Create the user
useradd -c "${COMMENT}" -m "${USER_NAME}"
# -m: create directory


# Set the password for the user
echo ${PASSWORD} | passwd --stdin ${USER_NAME}
# put the value stored in variable PASSWORD to shell-built in passwd and mark it as a standard input for the username ${USER_NAME}

# Force password change on first login
passwd -e ${USER_NAME}
 
