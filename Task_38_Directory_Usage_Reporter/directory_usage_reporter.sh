#!/bin/bash

EMAIL="adityarajic1101@gmail.com"
HOST=$(hostname)
NOW=$(date +"%Y-%m-%d %H:%M:%S")
SUBJECT="Disk Usage Report - Top 10 Directories on $HOST at $NOW"

# Generate the disk usage report as a string
BODY=$(cat <<EOF
Hello Administrator,

This is an automated disk usage report from host: $HOST

Status Update:
--------------
As of $NOW, here are the top 10 space-consuming directories:

$(du -ahx / | sort -rh | head -n 10 | awk '{printf "%-10s %s\n", $1, $2}')

Best regards,
Disk Monitor Script
$HOST
EOF
)

# Send the email
echo "$BODY" | mail -s "$SUBJECT" "$EMAIL"
