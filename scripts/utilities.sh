#!/usr/bin/env bash
. scripts/log_function.sh

# Utility Programs
utilities_installation () {
    log -i "===> Installing Utilities"
    sudo dnf install -y git
    sudo dnf install -y vim
    log -s "===> Successfully Installed Utilities"
}
