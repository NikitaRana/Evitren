#!/bin/bash

# This script generates a random password for each user specified on the command line

#  Display what the user typed on the command line
echo "Displaying the command line arguments"
echo "First command line argument: ${0}"
echo "Second command line argument: ${1}"
echo "Third command line argument: ${2}"

# Display the path and filename of the script 
echo "The directory name is $(dirname ${0}) and filename is $(basename ${0})"

# Display the number of arguments passed at command line
# (Inside the script they are parameters, outside they are arguments)
NUMBER_OF_PARAMETERS="${#}"
echo "The number of command line arguments are ${NUMBER_OF_PARAMETERS}"

# Make sure they atleast supply one argument
if [[ "${NUMBER_OF_PARAMETERS}" -lt 1 ]]
then
  echo "Usage: ${0} USER_NAME [USER_NAME]..."
  exit 1
fi

# Generate and display a password for each parameter using ${@}
echo "Using @ special variable"
for USER_NAME in "${@}":
	do
		PASSWORD=$(date +%s%N | sha256sum | head -c48)
		echo "${USER_NAME}: ${PASSWORD}"
	done

# Generate and display a password for one combined parameter using ${*}
echo "Using * special variable"
for USER_NAME in "${*}":
	do
		PASWORD=$(date +%s%N | sha256sum | head -c48)
		echo "${USER_NAME}: ${PASSWORD}"
	done
