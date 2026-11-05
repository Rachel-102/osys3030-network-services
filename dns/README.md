# BIND9 DNS

## Installation
sudo apt install bind9 dnsutils

## Configuration
BIND9 provides DNS resolution for the lab network.
The configuration includes the innovate.lab zone.

## Recovery
sudo cp named.conf.local /etc/bind/
sudo cp named.conf.options /etc/bind/
sudo cp db.innovate.lab /etc/bind/
sudo named-checkconf
sudo named-checkzone innovate.lab /etc/bind/db.innovate.lab
sudo systemctl restart bind9

## Verification
sudo named-checkconf
dig @127.0.0.1 innovate.lab
sudo systemctl status bind9
