#!/bin/bash

# ANSI color codes
GREEN="\e[32m"
BOLD="\e[1m"
RESET="\e[0m"

# System Info
HOSTNAME=$(hostname)
IP=$(hostname -I | awk '{print $1}')
UPTIME=$(uptime -p)
LAST_LOGIN=$(last -n 1 | awk '{print $1, $2, $3, $4, $5, $6}')

# Print Matrix-style MOTD
echo -e "${BOLD}${GREEN}"
echo "--------------------------------------------------"
echo "         .:: SYSTEM ACCESS GRANTED ::.           "
echo "--------------------------------------------------"
echo " Hostname    : $HOSTNAME"
echo " IP Address  : $IP"
echo " Uptime      : $UPTIME"
echo " Last Login  : $LAST_LOGIN"
echo "--------------------------------------------------"
echo -e "${RESET}"
