#!/bin/bash

# This script generates a list of random passwords.

# A random number as a password
PASSWORD="${RANDOM}"
echo "Your password is ${PASSWORD}"

#Three random numbers together
THREE_PASSWORD="${RANDOM}${RANDOM}${RANDOM}"
echo "More secure password having three random numbers: ${THREE_PASSWORD}"

# Use the current date/time as the basis for the password 
PASSWORD=$(date +%s)

echo "Epoch Time Password: ${PASSWORD}"

#use the current date/time as the basis for the password with %N
PASSWORD=$(date +%s%N)
echo "Epoch Time with Nano Seconds Password ${PASSWORD}"

# Using the checksum method to calcuate the hash of the password
HASHED_PASSWORD=$(date +%s%N | sha1sum)
echo "The hashed password is ${HASHED_PASSWORD}"

# Creating a better password
OTP_PASSWORD=$(date +%s%N | sha256sum | head -c32)
echo "The better versioned OTP password: ${OTP_PASSWORD}"

#even better password by adding a random number 
BETTER_PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c48)
echo "This password is 48 bits: ${BETTER_PASSWORD}"

#using special characters in the password by utilising functions like fold, shuf, head 
SPECIAL_CHARACTER=$(echo "~!@#$%^&*()_+-=" | fold -w1 | shuf | head -c1)
echo "Best Password with special characters: ${BETTER_PASSWORD}${SPECIAL_CHARACTER}"

