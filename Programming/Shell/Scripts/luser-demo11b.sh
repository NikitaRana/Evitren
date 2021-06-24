#!/bin/bash

# This script generates a random password
# This user can set the password length with -l and add a special chracter with -s
# Verbose mode can be enabled with -v

usage(){
    echo "Usage: ${0} [-vs] [-l LENGTH]" >&2
    echo 'Generate a random password.'
    echo ' -l       LENGTH Specify the password length.'
    echo ' -s       Append a special character to the password.'
    echo ' -v       Increase verbosity.'
    exit 1
}

log(){
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" = 'true' ]]
    then
        echo "${MESSAGE}"
    fi
}

# Set a default password length
LENGTH=48

# any option which needs to be have a mandatory value can be followed by a colon. 
# Like in this case '-l' option is a mandatory option
while getopts vl:s OPTION 
do
    case ${OPTION} in
    v)
        VERBOSE='true'
        log 'Verbose mode on.'
        ;;
    l)
        LENGTH="${OPTARG}"
        ;;
    s)
        USE_SPECIAL_CHARACTER='true'
        ;;
    ?)
        # echo 'Invalid option. Try again!' >&2
        # exit 1
        # ;;
        usage
        ;;
    esac
done

echo "Number of arguments: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

# Inspect OPTIND
# It is used to give the position of the next command line argument following the options
echo "OPTIND: ${OPTIND}"

# See output below for OPTIND:
# [vagrant@localusers vagrant]$ ./luser-demo11b.sh -sl 8 extra-stuff
# Number of arguments: 3
# All args: -sl 8 extra-stuff
# First arg: -sl
# Second arg: 8 
# Third arg: extra-stuff
# OPTIND: 3 <- because the first cmd arg 8 is at position 3 following the options -sl
# 9589f77e(

# Remove the options while leaving the command    
shift "$(( OPTIND - 1 ))"

echo "After the shift"
echo "Number of arguments: ${#}"
echo "All args: ${@}"
echo "First arg: ${1}"
echo "Second arg: ${2}"
echo "Third arg: ${3}"

if [[ "${#}" -gt 0 ]]
then 
    usage
fi

log 'Generating a password'

PASSWORD=$(date +%s%N{RANDOM}${RANDOM} | sha256sum | head -c${LENGTH})

# Append a special character if requested to do so
if [[ "${USE_SPECIAL_CHARACTER}" = 'true' ]]
then
    log 'Selecting a random special character.'
    SPECIAL_CHARACTER=$(echo '!@#$%^&*()_+=' | fold -w1 | shuf | head -c1)
    PASSWORD="${PASSWORD}${SPECIAL_CHARACTER}"
fi

log 'Done.'
log 'Here is the password.'
echo "${PASSWORD}"

exit 0


