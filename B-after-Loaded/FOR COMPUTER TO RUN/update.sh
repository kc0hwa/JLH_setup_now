#!/bin/bash

# Function to clean up unused packages and cache
clean() {
    echo "Starting clean-up..."
    apt auto-remove -y
    apt auto-clean -y
    apt purge -y
    echo "Clean-up completed."
}

# Function to update and upgrade the system
update() {
    echo "Starting system update..."
    clean
    echo "Updating package lists..."
    apt update
    echo "Upgrading installed packages..."
    apt -y full-upgrade
    clean
    echo "System update completed."
}

# Main script execution
update
