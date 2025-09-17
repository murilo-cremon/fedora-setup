#!/usr/bin/env bash
. scripts/log_function.sh

# Utility Programs
utilities_installation () {
    log -i "===> Installing Utilities"
    sudo dnf install -y git
    sudo dnf install -y vim
    sudo dnf install -y plasma-workspace-x11 # Fix fullscreen bug in KDE
    log -s "===> Successfully Installed Utilities"
}
