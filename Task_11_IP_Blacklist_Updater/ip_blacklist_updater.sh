#!/bin/bash

# === CONFIGURATION ===
BLACKLIST_URL="https://raw.githubusercontent.com/stamparm/ipsum/master/ipsum.txt"
TMP_IP_LIST="/tmp/blacklist.txt"
LOG_FILE="/var/log/ip_blacklist.log"
BACKUP_FILE="/etc/iptables.backup.$(date +%F-%H%M%S)"

# === ROOT CHECK ===
if [[ $EUID -ne 0 ]]; then
    echo " X  This script must be run as root."
    exit 1
fi

# === BACKUP IPTABLES ===
echo "[+] Backing up iptables to: $BACKUP_FILE"
iptables-save > "$BACKUP_FILE"

# === DOWNLOAD BLACKLIST ===
echo "[+] Downloading blacklist from $BLACKLIST_URL"
curl -s "$BLACKLIST_URL" -o "$TMP_IP_LIST"

# === SANITY CHECK ===
if [[ ! -s $TMP_IP_LIST ]]; then
    echo " X  Blacklist download failed or is empty"
    exit 1
fi

# === PROCESS BLACKLIST ===
echo "[+] Processing IPs..."
ADDED_COUNT=0

# Process only first field (IP only)
cut -f1 "$TMP_IP_LIST" | while read -r ip; do
    # Skip comments or empty lines
    [[ "$ip" =~ ^#.*$ || -z "$ip" ]] && continue

    echo "→ Checking IP: $ip"

    # Check if IP already blocked
    if iptables -C INPUT -s "$ip" -j DROP 2>/dev/null; then
        echo "   Already blocked: $ip"
        continue
    fi

    # Block IP
    iptables -A INPUT -s "$ip" -j DROP
    echo "$(date +'%F %T') - Blocked $ip" >> "$LOG_FILE"
    echo " Blocked: $ip"
    ((ADDED_COUNT++))
done

# === SAVE IPTABLES PERSISTENTLY ===
iptables-save > /etc/sysconfig/iptables

echo "[+] Done. Added $ADDED_COUNT new IP(s) to iptables."

# === CLEANUP ===
rm -f "$TMP_IP_LIST"
