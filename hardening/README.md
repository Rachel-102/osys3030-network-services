# SSH Hardening

## Installation
sudo apt install openssh-server

## Configuration
The SSH service provides secure remote access.
Password authentication is disabled, and SSH keys are used.

## Recovery
sudo cp sshd_config /etc/ssh/sshd_config
sudo sshd -t
sudo systemctl restart ssh

## Verification
sudo sshd -t
sudo systemctl status ssh
