#!/bin/bash
# Simple script for creating a user locally

if [[ "${UID}" -ne 0 ]] 
then
	echo "you are not the root user!"
	exit 1
fi

read -p 'Enter desired username: '  USER_NAME
read -p 'Enter your name or application name that will use this account: ' NAME
read -p 'Enter desired password for the account: ' PASSWORD

useradd -c "${NAME}" -m  ${USER_NAME}
if [[ "${?}" -ne 0 ]]
then 
	echo 'Account creation failed.'
	exit 1
fi

echo "${USER_NAME}:${PASSWORD}" | chpasswd

if [[ "${?}" -ne 0 ]]
then
	echo 'The password could not be created.'
	exit 1
else
	echo "User ${USER_NAME} was successfully created on ${HOSTNAME} with initial password of ${PASSWORD}"
fi

passwd -e ${USER_NAME}

