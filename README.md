# OSYS3030 - Linux Network Appliance Documentation

**Student:** Rachel Al Awar
**Server:** rachel
**Operating System:** Ubuntu Server 26.04.1 LTS

## Project Overview

This project documents my Linux network appliance and its network services. The server provides DNS, DHCP, SSH access, firewall protection, and NAT routing.

## Network Configuration

| Interface | IP Address | Purpose |
|---|---|---|
| ens18 | 10.20.0.202/23 | WAN |
| ens19 | 10.109.0.250/24 | LAN |

**LAN subnet:** 10.109.0.0/24
**Default gateway:** 10.20.0.1

## Network Topology

Internet / Campus Network
        |
        |
ens18 - 10.20.0.202
        |
Ubuntu Server (rachel)
        |
ens19 - 10.109.0.250
        |
LAN - 10.109.0.0/24
        |
Alpine Linux Client

## Network Services

- SSH: Secure remote administration.
- BIND9: DNS resolution.
- Kea DHCPv4: Automatic IP address assignment.
- UFW: Firewall protection.
- NAT: Allows private LAN clients to access external networks.

## Configuration Directories

- hardening/: SSH configuration and security documentation.
- dns/: BIND9 DNS configuration and documentation.
- dhcp/: Kea DHCP configuration and documentation.
- fw/: UFW firewall and NAT configuration.
- scripts/: Automated deployment and verification scripts.

## Verification

Check services:

sudo systemctl status ssh bind9 kea-dhcp4-server ufw

Check networking:

ip -br addr
ip route

## Recovery

Restore the configuration files from this repository, validate them, and restart the relevant services. Automated deployment and verification scripts are provided in the scripts directory.

## Peer Audit

To be completed after reviewing a classmate's repository.
