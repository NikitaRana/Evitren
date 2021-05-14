#!/bin/bash


# Demonstrate the use of while loop
element=1
while [[ "${element}" -eq 1 ]]
do
	echo "The value of element is ${element}"
	element=8
done

# Demonstrate the use of infinite loop
#while [[ true ]]
#do 
#	echo "Infinite loop!!"
#	sleep 3 
#done

# Demonstrate the usage of while loop and shift command
echo "Parameter 1: ${1}"
echo "Parameter 2: ${2}"
echo "Parameter 3: ${3}"

#Loop through all positional arguments 
while [[ "${#}" -gt 0 ]]
do 
	echo "Number of parameters: ${#}"
	echo "Parameter 1: ${1}"
	echo "Parameter 2: ${2}"
	echo "Parameter 3: ${3}"
	echo
	shift
done
