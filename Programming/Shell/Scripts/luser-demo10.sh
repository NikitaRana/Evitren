#!/bin/bash

#log() {
#	echo 'Function definition using method 1'
#}

#log # calling the function


#function log2 {
#	echo 'Function definition using method 2'
#}

#log2 # calling the function

log() {
	# This function sends a message t syslog and to standard output if VERBOSE is true
	# local VERBOSE="${1}" #chop off the value assigned to VERBOSE
	# shift
	local MESSAGE="${@}"
	if [[ "${VERBOSE}" = 'true' ]]
	then
		echo "${MESSAGE}"
	fi
	logger -t luser-demo10.sh "${MESSAGE}"
}	

backup_file(){
	# This function creates a backup of a file. Returns a non-zero status on error. 
	local FILE="${1}"

	# Make sure the file exists
	if [[ "${FILE}" ]]
	then
		local BACKUP_FILE="/var/tmp/$(basename ${FILE}).$(date +%F-%N)"
                log "Backing up ${FILE} to ${BACKUP_FILE}"
		
		# The exit status of the function will be the exit status of the cp command
		cp -p ${FILE} ${BACKUP_FILE}  #p - preserves the file's ownership and last modified timestamp of the file
	else
		# The file does not exist, so return a non-zero exit status
		return 1 # used to exit the function only and not the entire script
	fi	

}	 

# METHOD 1
readonly VERBOSE='true'

# METHOD 2
# VERBOSE='true'
# readonly VERBOSE

log 'Hello!' #this will not get printed because verbose is not set
log 'This is fun' #this will get printed because verbose is set 

backup_file '/etc/passwd'


# Make a decision based on the ext statos of the function
if [[ "${?}" -eq '0' ]]
then
	log 'File backup succeeded!'
else
	log 'File backup failed!'
	exit 1 # exit is meant to exit the entire script
fi
