#!/bin/bash

# === CONFIGURATION ===
VPN_INTERFACE="tun1" 
OVPN_CONFIG="/media/sf_shared_vm/vpnbook-us178-tcp443.ovpn"
AUTH_FILE="/etc/openvpn/auth.txt"
LOG_FILE="/var/log/vpn_monitor.log"
EMAIL="adityarajic1101@gmail.com" 

# === Logging Function ===
log() {
    local MSG="$1"
    local TIME=$(date '+%Y-%m-%d %H:%M:%S')
    echo "$TIME - $MSG" | tee -a "$LOG_FILE"
    logger -t vpn_validator "$MSG"
}

# === Check if VPN Interface is Up ===
if ip a | grep -q "$VPN_INTERFACE"; then
    log "VPN is active on interface $VPN_INTERFACE."
else
    log "VPN is NOT active. Attempting reconnection..."

    # Kill any existing OpenVPN session
    sudo pkill openvpn

    # Reconnect using OpenVPN with credentials
    sudo nohup openvpn --config "$OVPN_CONFIG" --auth-user-pass "$AUTH_FILE" --daemon &

    sleep 10

    # Recheck connection
    if ip a | grep -q "$VPN_INTERFACE"; then
        log "VPN reconnected successfully."
        echo "VPN was disconnected and has been reconnected at $(date)." | mail -s "VPN Reconnected" "$EMAIL"
    else
        log "VPN reconnection failed."
        echo "VPN reconnection failed at $(date)." | mail -s "VPN Reconnect FAILED" "$EMAIL"
    fi
fi

