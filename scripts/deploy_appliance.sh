#!/bin/bash
# ==============================================================================
# OSYS3030 - Network Appliance Automated Deployment Script (Sample)
# Deploys configurations for SSH, BIND9, Kea DHCPv4, and UFW NAT Masquerade
# ==============================================================================
set -euo pipefail

# Ensure script is run as root
if [ "$EUID" -ne 0 ]; then
  echo "Error: This script must be run as root (use sudo)." >&2
  exit 1
fi

# Back up existing configurations before deployment
BACKUP_DIR="/root/appliance-backups/$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

for file in /etc/ssh/sshd_config /etc/bind/named.conf.local /etc/bind/named.conf.options /etc/bind/db.innovate.lab /etc/kea/kea-dhcp4.conf /etc/ufw/before.rules; do
  if [ -f "$file" ]; then
    mkdir -p "$BACKUP_DIR$(dirname "$file")"
    cp -a "$file" "$BACKUP_DIR$file"
  fi
done

echo "Configuration backup saved to $BACKUP_DIR"

echo "=== Starting Appliance Deployment ==="

# Step 1: Install Core Packages
echo "--> Installing packages..."
apt update -y
apt install -y bind9 bind9utils dnsutils kea-dhcp4-server ufw iptables

# Step 2: Restore and validate configurations
echo "=== Restoring configurations ==="

install -m 0644 dns/named.conf.options /etc/bind/named.conf.options
install -m 0644 dns/named.conf.local /etc/bind/named.conf.local
# DNS directory already exists
install -m 0644 dns/db.innovate.lab /etc/bind/db.innovate.lab

install -m 0644 dhcp/kea-dhcp4.conf /etc/kea/kea-dhcp4.conf
install -m 0644 fw/before.rules /etc/ufw/before.rules

# Validate and restore SSH hardening
sshd -t -f hardening/sshd_config
install -m 0644 hardening/sshd_config /etc/ssh/sshd_config

# Validate configurations
named-checkconf
named-checkzone innovate.lab /etc/bind/db.innovate.lab
runuser -u _kea -- kea-dhcp4 -t /etc/kea/kea-dhcp4.conf

# Validate SSH configuration without restarting SSH
sshd -t

# Step 3: Enable routing and NAT
echo "=== Configuring routing ==="
sysctl -w net.ipv4.ip_forward=1

# Step 4: Configure firewall
echo "=== Configuring firewall ==="
ufw allow 2222/tcp comment 'SSH'
ufw allow in on ens18 to any port 53 comment 'DNS'
ufw allow in on ens19 to any port 67 proto udp comment 'DHCP'
ufw default allow outgoing
ufw default allow routed
ufw reload

# Step 5: Restart network services
systemctl restart named
systemctl enable named
systemctl restart kea-dhcp4-server
systemctl enable kea-dhcp4-server

echo "=== Deployment Complete! Run ./scripts/verify_appliance.sh to test ==="
