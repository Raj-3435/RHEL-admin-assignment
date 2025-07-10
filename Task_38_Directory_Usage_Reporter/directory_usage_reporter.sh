#!/bin/bash

# CONFIGURATION
REPORT_FILE="/tmp/disk_usage_report.txt"
EMAIL="adityarajic1101@gmail.com" 
SUBJECT="Daily Disk Usage Report - Top 10 Directories"

# STEP 1: Calculate Disk Usage
echo "Top 10 Space-Consuming Directories as of $(date)" > "$REPORT_FILE"
echo "====================================================" >> "$REPORT_FILE"
du -ahx / | sort -rh | head -n 10 >> "$REPORT_FILE"

# STEP 2: Email the Report
if command -v mail > /dev/null; then
    mail -s "$SUBJECT" "$EMAIL" < "$REPORT_FILE"
else
    echo "Mail command not found. Please install mailutils or mailx to send email."
fi
