# 🛠️ RHEL Shell Scripting Assignment – Aditya Raj

## 📅 Date: July 10, 2025

---
## 📂 Overview

This repository contains 5 RHEL shell scripting tasks completed as part of a Linux system administration training project.  
Each task automates a real-world system admin function such as directory monitoring, VPN health validation, dynamic MOTD display, and more.

---

## 🔧 Prerequisites

- RHEL 9 or compatible Linux environment
- Root/sudo privileges (for some scripts)
- Tools used:
  - `iptables` for IP blocking
  - `smartctl` from `smartmontools` for disk health checks
  - `crontab` for scheduling tasks
  - `OpenVPN` for VPN monitoring

---

## 📁 Folder Structure

rhel-admin-assignment/
├── Task_11_IP_Blacklist_Updater/
│ └── ip_blacklist_updater.sh
├── Task_25_Dynamic_Welcome_msg/
│ └── dynamic_motd.sh
├── Task_33_Smartctl_Health_Report/
│ └── smartctl_health_report.sh
├── Task_37_VPN_Validator/
│ ├── vpn_validator.sh
│ └── nohup.out
├── Task_38_Directory_Usage_Reporter/
│ └── directory_usage_reporter.sh
└── README.md

---

### 📌 Task 11: IP Blacklist Updater
**Folder:** `Task_11_IP_Blacklist_Updater`  
**Script:** `ip_blacklist_updater.sh`  
**Description:**  
Fetches and blocks suspicious IPs using firewall rules. Logs actions in `/var/log/ip_blacklist.log`.

---

### 📌 Task 25: Dynamic Welcome Message
**Folder:** `Task_25_Dynamic_Welcome_msg`  
**Script:** `dynamic_motd.sh`  
**Description:**  
Displays a hacker-style dynamic message of the day (MOTD) at login. Can be customized from `/usr/local/bin/`.

---

### 📌 Task 33: SMART Health Report
**Folder:** `Task_33_Smartctl_Health_Report`  
**Script:** `smartctl_health_report.sh`  
**Description:**  
Scans HDD/SSD drives using `smartctl` and logs their health status. Skips unsupported drives.

---

### 📌 Task 37: VPN Validator
**Folder:** `Task_37_VPN_Validator`  
**Files:** `vpn_validator.sh`, `nohup.out`  
**Description:**  
Monitors VPN connectivity. Automatically restarts VPN if down.  
**Log file (`nohup.out`)** contains warnings and run-time messages from the validator.

---

### 📌 Task 38: Directory Usage Reporter
**Folder:** `Task_38_Directory_Usage_Reporter`  
**Script:** `directory_usage_reporter.sh`  
**Description:**  
Reports disk usage of subdirectories under a given path. Useful for monitoring storage.

---

## 🛠️ How to Run Each Script

```bash
chmod +x scriptname.sh
./scriptname.sh
Or schedule via `crontab -e` for automation.

---
## 🧪 Testing Instructions

You can test each script manually before scheduling with cron.

For example:
```bash
sudo ./ip_blacklist_updater.sh
sudo ./smartctl_health_report.sh

---

## 📁 Notes

- All scripts were copied from `/usr/local/bin/`.
- Log file (`nohup.out`) was included for completeness.

---
## ⏲️ How to Automate with Cron

Each script can be scheduled using `crontab -e`. Example:

```bash
# Run IP blacklist updater daily at 3:00 AM
0 3 * * * /usr/local/bin/ip_blacklist_updater.sh

# Run directory usage report every day at 8:00 AM
0 8 * * * /usr/local/bin/directory_usage_reporter.sh

---

## 🙋‍♂️ Author

**Name:** Aditya Raj 
**Email:** adityaraj3435@gmail.com 
**GitHub:** [Raj-3435](https://github.com/Raj-3435)

