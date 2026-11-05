# UFW Firewall and NAT

## Installation
sudo apt install ufw iptables

## Configuration
UFW manages firewall rules.
NAT masquerading allows LAN clients to access external networks
through the WAN interface.

WAN: ens18
LAN: ens19
LAN subnet: 10.109.0.0/24

## Recovery
sudo cp before.rules /etc/ufw/before.rules
sudo sysctl -w net.ipv4.ip_forward=1
sudo ufw reload

## Verification
sudo ufw status verbose
sudo iptables -t nat -L -n -v
sysctl net.ipv4.ip_forward
