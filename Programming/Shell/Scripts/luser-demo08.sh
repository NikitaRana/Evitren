#!/bin/bash

# This script demonstrates I/O redirection

echo "# Redirect STDOUT to a file"
FILE="/tmp/data"
head -n1 /etc/passwd > ${FILE}

# Redirect STDIN from a file to a program
echo "# Redirect STDIN from a file to a program" 
read LINE < ${FILE}
echo "LINE contains: ${LINE}"

# Redirect STDOUT to a file, overwiritng the file
echo "# Redirect STDOUT to a file, overwiritng the file"
head -n3 /etc/passwd > ${FILE}
echo
echo "Contents of ${FILE}"
cat ${FILE}

# Redirect STDOUT to a file, appending the file
echo "# Redirect STDOUT to a file, appending the file"
head -n5 /etc/passwd >> ${FILE}
echo
echo "Appended Contents of ${FILE}" 
cat ${FILE}

echo "RANDOM ${RANDOM}" >> ${FILE}
cat ${FILE}

# Redirect STDIN to a program, using FD 0
echo "# Redirect STDIN to a program, using FD 0"
read LINE 0< ${FILE}
echo 
echo "LINE FD contains: ${LINE}"

# Redirect STDOUT to a file using FD 1, overwriting the file
echo "# Redirect STDOUT to a file using FD 1, overwriting the file"
head -n3 /etc/passwd 1> ${FILE}
cat ${FILE}

# Redirect STDERR to a file using FD 2
echo "# Redirect STDERR to a file using FD 2"
ERR_FILE="/tmp/data.err"
head -n3 /etc/passwd /fakefile 2> "${ERR_FILE}"

# Redirect STDOUT and STDERR to a file
echo "# Redirect STDOUT and STDERR to a file"
head -n3 /etc/passwd /fakefile &> ${FILE}
echo
echo "Contents of ${FILE}:"
cat ${FILE}

# Redirect a STDOUT and STDERR through a pipe
echo "# Redirect a STDOUT and STDERR through a pipe"
echo 
head -n3 /etc/passwd /fakefile |& cat -n

# Send output to STDERR
ERROR_FILE="error_file.err"
echo "# Send output to STDERR"
echo "This is STDERR!" >&2
 
# DISARD STDOUT
echo "# DISCARD STDOUT"
echo "Discarding STDOUT"
head -n3 /etc/passwd /fakefile > /dev/null

# DISCARD STDERR
echo "# DISCARD STDERR"
echo "Discarding STDERR"
head -n3 /etc/passwd /fakefile 2> /dev/null

# DISCRD STDOUT and STDERR
echo "# DISCARD STDOUT AND STDERR"
echo "Discarding STDOUT and STDERR"
head -n3 /etc/passwd /fakefile &> /dev/null

# Clean up
rm ${FILE} ${ERROR_FILE} ${ERR_FILE} &> /dev/null





