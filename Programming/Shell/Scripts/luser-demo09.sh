#!/bin/bash

#This script demonstrates the case statement

#if [[ "${1}" = 'start' ]]
#then
#	echo 'starting'
#elif [[ "${1}" = 'stop' ]]
#then
#	echo 'stopping'
#elif [[ "${1}" == 'status' ]]
#then
#	echo 'status'
#else
#	echo 'supply a valid operation' >&2 # putting to standard error
#	exit 1
#fi


#Using case statement

case "${1}" in 
	start)
		echo 'starting'
		;;
	stop)
		echo 'stopping'
		;;
	status|state|--status|--state)
		echo 'status'
		;;
	*)  #this is like else condition in if-elif-else. * is anything that hasnt alreadt been accounted for or catched in the previous statements
		echo 'Supply a valid condition.' >&2
		exit 1
		;;
esac
