#!/bin/bash

# Proxmox Repository Setup Script
# Removes the enterprise repository and configures the no-subscription repository.

# Variables
ENTERPRISE_REPO="/etc/apt/sources.list.d/pve-enterprise.list"
FREE_REPO="deb http://download.proxmox.com/debian/pve bookworm pve-no-subscription"

# Function to remove the enterprise repository
remove_enterprise_repo() {
    if [ -f "$ENTERPRISE_REPO" ]; then
        echo "Removing Proxmox Enterprise repository..."
        mv "$ENTERPRISE_REPO" "${ENTERPRISE_REPO}.backup"
        echo "Enterprise repository removed. Backup saved as ${ENTERPRISE_REPO}.backup."
    else
        echo "No Enterprise repository found. Skipping removal."
    fi
}

# Function to add the free repository
add_free_repo() {
    echo "Adding Proxmox no-subscription repository..."
    echo "$FREE_REPO" > /etc/apt/sources.list.d/pve-no-subscription.list
    echo "No-subscription repository added."
}

# Function to update package lists
update_package_list() {
    echo "Updating package lists..."
    apt update
    echo "Package lists updated."
}

# Main Execution
echo "Starting Proxmox repository setup..."
remove_enterprise_repo
add_free_repo
update_package_list
echo "Proxmox repository setup completed successfully."
