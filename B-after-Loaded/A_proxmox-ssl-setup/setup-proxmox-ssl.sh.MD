# Proxmox SSL Setup Script

A simple helper script to set up a valid HTTPS certificate for your Proxmox server using Let's Encrypt and ACME.

## Prerequisites
1. A public DNS record for your Proxmox server.
2. Ports 80 and 443 open and forwarded to the server.
3. Proxmox 6.4 or later.

## How to Use

### One-Line Command to Download and Run
Run the following command on your Proxmox server to download and execute the script:

```bash
bash <(curl -s https://raw.githubusercontent.com/kc0hwa/JLH_setup_now/refs/heads/main/B-after-Loaded/A_proxmox-ssl-setup/setup-proxmox-ssl.sh.SH)
