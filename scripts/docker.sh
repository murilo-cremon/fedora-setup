#!/usr/bin/env bash
. scripts/log_function.sh

# Installation function and some docker settings on the system
docker_installation_configuration () {
    log -i "===> Installing & Configurating Docker"
    sudo dnf install -y docker
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    newgrp docker
    log -s "===> Docker installed and configured successfully"
}
