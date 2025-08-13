#!/usr/bin/env bash
source log_function.sh
set -e

empty_message=""

# System update function
update_system () {
    if [[ -n "$(dnf check-update)" ]]; then
        log -i "===> Updating System..."
        sudo dnf update -y
        log -s "===> Updating System Successfully"
        echo "$empty_message"
    fi

    if [[ -n "$(dnf check-upgrade)" ]]; then
        log -i "===> Updating System..."
        sudo dnf upgrade -y
        echo "$empty_message"
        log -s "===> Updating System Successfully"
    fi
}

# Function that installs RPM packages in Fedora
install_rpm_repositories() {
    local rpm_free_return=$(dnf repolist | grep rpmfusion-free)
    local rpm_nonfree_return=$(dnf repolist | grep rpmfusion-nonfree)

    if [[ -z "$rpm_free_return" ]]; then
        log -i "===> Install Free RPM Packages..." &&
        sudo dnf install \
            https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm \
            -y &&
        log -s "===> Successfully Installed RPM Free Packages"
        echo "$empty_message"
    fi

    if [[ -z "$rpm_nonfree_return" ]]; then
        log -i "===> Install Non-Free RPM Packages..." &&
        sudo dnf install \
            https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
            -y
        log -s "===> Successfully Installed RPM Non-Free Packages"
        echo "$empty_message"
    fi
}

# Helper function that performs the installation of flatpaks directly from flathub
auxiliary_installation_flatpak () {
    local program="$1"
    local formatted_name=$(echo "$program" | rev | cut -d'.' -f1 | rev)
    echo "===> Instalando $formatted_name"
    flatpak install -y flathub "$program"
    echo "$empty_message"
}

# Function that is passed to check if new packages are needed
addition_extra_programs_flatpaks () {
    read -p "Ainda deseja instalar algum flatpak? [Y/n]: " awnser
    echo "$empty_message"

    if [[ "$awnser" = "Y" ]]; then
        read -p "Digite os flatpaks separados por espaço: " -a extra_flatpaks

        for program in "${extra_flatpaks[@]}"; do
            auxiliary_installation_flatpak "$program"
        done
    fi
}

# Function that is called to install flathub packages
install_flatpaks () {
    # Adicionando Flathub para flatpaks
    local flathub_installed=$(flatpak remote-list | grep flathub)

    if [[ -z "$flathub_installed" ]]; then
        log -i "===> Installing Flathub Repository for Flatpaks"
        sudo flatpak remote-add \
            --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        echo "$empty_message"
    fi

    # Default programs I use that I always install
    local flatpak_programs=(
        "com.valvesoftware.Steam"
        "com.spotify.Client"
        "com.discordapp.Discord"
    )

    for program in "${flatpak_programs[@]}"; do
        auxiliary_installation_flatpak "$program"
    done

    addition_extra_programs_flatpaks
    log -s "===> Flatpaks installed successfully"
}

# Installation function and some docker settings on the system
docker_installation_configuration () {
    log -i "===> Installing & Configurating Docker"
    sudo dnf install -y docker
    sudo systemctl enable --now docker
    sudo usermod -aG docker $USER
    newgrp docker
    echo "$empty_message"
    log -s "===> Docker installed and configured successfully"
}

# Utility Programs
utilities_installation () {
    log -i "===> Installing Utilities"
    sudo dnf install -y git
    sudo dnf install -y vim
    log -s "===> Successfully Installed Utilities"
}

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
