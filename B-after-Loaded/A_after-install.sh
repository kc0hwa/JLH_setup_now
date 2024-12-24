#!/bin/bash

set -euo pipefail

# Global Variables
ENTERPRISE_LIST="/etc/apt/sources.list.d/pve-enterprise.list"
NOSUBSCRIPTION_REPO="deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription"

# Functions
disable_enterprise_repo() {
    if [[ -f $ENTERPRISE_LIST ]]; then
        printf "Disabling Proxmox Enterprise repository...\n"
        sed -i 's/^deb/#deb/g' "$ENTERPRISE_LIST"
    else
        printf "Enterprise repository file not found. Skipping...\n"
    fi
}

add_no_subscription_repo() {
    printf "Adding No-Subscription repository...\n"
    local pve_list="/etc/apt/sources.list.d/pve-no-subscription.list"
    if [[ ! -f $pve_list ]]; then
        printf "%s\n" "$NOSUBSCRIPTION_REPO" > "$pve_list"
    else
        printf "No-Subscription repository already exists. Skipping...\n"
    fi
}

fix_https() {
    printf "Ensuring HTTPS transport support...\n"
    if ! apt-get install -y apt-transport-https; then
        printf "Failed to install apt-transport-https. Aborting...\n" >&2
        return 1
    fi
}

cleanup_apt() {
    printf "Running apt cleanup...\n"
    apt-get autoremove -y
    apt-get autoclean -y
    apt-get autopurge -y
}

update_and_upgrade() {
    printf "Updating and upgrading system packages...\n"
    apt-get update
    apt-get full-upgrade -y
}

reboot_system() {
    printf "Rebooting system...\n"
    reboot
}

main() {
    disable_enterprise_repo
    add_no_subscription_repo
    fix_https
    cleanup_apt
    update_and_upgrade
    cleanup_apt
    reboot_system
}

# Execute Main Function
main
