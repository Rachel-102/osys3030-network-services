# Kea DHCPv4

## Installation
sudo apt install kea-dhcp4-server

## Configuration
Kea DHCPv4 provides automatic IP addresses for LAN clients
on the 10.109.0.0/24 network.

## Recovery
sudo cp kea-dhcp4.conf /etc/kea/
sudo kea-dhcp4 -t /etc/kea/kea-dhcp4.conf
sudo systemctl restart kea-dhcp4-server

## Verification
sudo kea-dhcp4 -t /etc/kea/kea-dhcp4.conf
sudo systemctl status kea-dhcp4-server
