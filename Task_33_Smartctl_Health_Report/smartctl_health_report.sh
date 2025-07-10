#!/bin/bash

# Step 1: Create a folder to save reports (if not already there)
REPORT_DIR="/var/log/smart_reports"
mkdir -p "$REPORT_DIR"

# Step 2: Get the current date and time for file name
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT_FILE="$REPORT_DIR/smart_report_$TIMESTAMP.txt"

# Step 3: Start writing the report
echo "SMART Health Report - $TIMESTAMP" > "$REPORT_FILE"
echo "===============================" >> "$REPORT_FILE"

# Step 4: Find all storage drives like /dev/sda, /dev/sdb, etc.
for DEVICE in /dev/sd*; do
    echo "Checking: $DEVICE" >> "$REPORT_FILE"
    echo "------------------" >> "$REPORT_FILE"

    # Check drive health
    HEALTH=$(smartctl -H "$DEVICE" | grep "SMART overall-health" || echo "No SMART data found")

    # Add full device info to report
    smartctl -a "$DEVICE" >> "$REPORT_FILE" 2>&1

    # Highlight health result
    if echo "$HEALTH" | grep -qi "FAILED"; then
        echo "⚠️ ALERT: $DEVICE - SMART FAILED" >> "$REPORT_FILE"
    elif echo "$HEALTH" | grep -qi "PASSED"; then
        echo "✅ OK: $DEVICE - SMART Passed" >> "$REPORT_FILE"
    else
        echo "❓ NOTE: $DEVICE - No health info" >> "$REPORT_FILE"
    fi

    echo "" >> "$REPORT_FILE"
done

