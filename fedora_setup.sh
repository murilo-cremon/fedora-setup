#!/usr/bin/env bash
set -e

. scripts/docker.sh
. scripts/flatpaks.sh
. scripts/update_system.sh
. scripts/rpm_repositories.sh
. scripts/utilities.sh
. scripts/pgadmin_desktop.sh

# Block responsible for calling the above installation functions
main() {
    update_system
    utilities_installation
    install_rpm_repositories
    install_flatpaks
    docker_installation_configuration

    if [[ $? -eq 0 ]]; then
        log -s "Update completed successfully!"
    else
        log -e "Error installing and updating dependencies!"
    fi
}

main
