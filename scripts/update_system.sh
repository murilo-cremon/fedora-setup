#!/usr/bin/env bash
. scripts/log_function.sh

# System update function
update_system () {
    if [[ -n "$(dnf check-update)" ]]; then
        log -i "===> Updating System..."
        sudo dnf update -y
        log -s "===> Updating System Successfully"
    fi

    if [[ -n "$(dnf check-upgrade)" ]]; then
        log -i "===> Updating System..."
        sudo dnf upgrade -y
        log -s "===> Updating System Successfully"
    fi
}
