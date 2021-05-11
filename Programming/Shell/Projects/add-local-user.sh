#!/bin/bash
#Shell script requirements:

# The script needs to be executed with superuser root privileges
if [[ "${UID}" -ne 0 ]]
then
	echo "Please execute the script with super user root privileges"
	exit 1
fi

# Get the username (login)
read -p 'Enter the username: ' USER_NAME

# Get the real name (contents for the desccription field)
read -p 'Enter your real name: ' COMMENT

# Get the password
read -p 'Enter to create a new password: ' PASSWORD

# Create the user with the password
useradd -c "${COMMENT}" -m "${USER_NAME}"

# Check to see if the useradd command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "The account creation was not successfull. Please try again."
	exit 1
else
	echo "The account for user ${COMMENT} was created successfully."
fi

# Set the password
echo ${PASSWORD} | passwd --stdin ${USER_NAME}

# Check to see if the passwd command succeeded
if [[ "${?}" -ne 0 ]]
then
	echo "Password creation failed!"
else
	echo "Password creation successfull"
fi


# Force password change on first login
passwd -e ${USER_NAME}


# Display the username, password, and the host where the user was created
HOST_NAME=$(hostname -s)
echo "Account creation successfull"
echo "Created Username: ${USER_NAME}"
echo "Created Password: ${PASSWORD}"
echo "Created at host: ${HOST_NAME}" 


















 
