#!/usr/bin/env bash
. scripts/log_function.sh

# Utility Programs
pgadmin_desktop_installation () {
    log -i "===> Installing PgAdmin4 Desktop"
    local pgadmin_installed=$(rpm -q pgadmin4-fedora-repo)

    if [[ -z pgadmin_installed ]]; then
        sudo rpm -i https://ftp.postgresql.org/pub/pgadmin/pgadmin4/yum/pgadmin4-fedora-repo-2-1.noarch.rpm
    fi

    sudo dnf update -y
    sudo dnf install pgadmin4-desktop
    log -s "===> Successfully Installed PgAdmin4"
}
