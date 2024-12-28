#!/bin/bash

# Proxmox SSL Setup Script
# Configure these values before running the script:
EMAIL="kc0hwa@gmail.com"       # Your email address for Let's Encrypt
DOMAIN="10.3.1.2"              # Your Proxmox server's domain name

# Helper script for setting up Let's Encrypt SSL on Proxmox
# Note: Requires Proxmox 6.4 or later with ACME support

# Function to check prerequisites
check_prerequisites() {
    echo "Checking prerequisites..."
    if ! command -v pveproxy &> /dev/null; then
        echo "Proxmox is not installed. Exiting."
        exit 1
    fi
    if ! command -v acme.sh &> /dev/null; then
        echo "ACME client is not installed. Installing acme.sh..."
        curl https://get.acme.sh | sh
    fi
}

# Function to configure ACME in Proxmox
configure_acme() {
    echo "Configuring ACME for Let's Encrypt..."

    # Enable ACME on Proxmox
    cat <<EOF > /etc/pve/priv/acme/settings.json
{
  "account-email": "$EMAIL"
}
EOF

    # Request SSL certificate
    pvenode config set --acme domains=$DOMAIN --acme plugin=standalone
    pvenode acme cert order
}

# Function to restart Proxmox services
restart_proxmox_services() {
    echo "Restarting Proxmox services..."
    systemctl restart pveproxy
    systemctl restart pvedaemon
}

# Main script execution
echo "Starting Proxmox SSL setup..."
check_prerequisites
configure_acme
restart_proxmox_services
echo "SSL setup completed successfully!"