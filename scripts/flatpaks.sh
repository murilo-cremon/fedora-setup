#!/usr/bin/env bash
. scripts/log_function.sh

# Helper function that performs the installation of flatpaks directly from flathub
auxiliary_installation_flatpak () {
    local program="$1"
    local formatted_name=$(echo "$program" | rev | cut -d'.' -f1 | rev)
    echo "===> Instalando $formatted_name"
    flatpak install -y flathub "$program"
}

# Function that is passed to check if new packages are needed
addition_extra_programs_flatpaks () {
    read -p "Ainda deseja instalar algum flatpak? [Y/n]: " awnser

    if [[ "$awnser" = "Y" ]]; then
        read -p "Digite os flatpaks separados por espaço: " -a extra_flatpaks

        for program in "${extra_flatpaks[@]}"; do
            auxiliary_installation_flatpak "$program"
        done
    fi
}

# Function that is called to install flathub packages
install_flatpaks () {
    local flathub_installed=$(flatpak remote-list | grep flathub)

    if [[ -z "$flathub_installed" ]]; then
        log -i "===> Installing Flathub Repository for Flatpaks"
        sudo flatpak remote-add \
            --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
    fi

    # Default programs I use that I always install
    local flatpak_programs=(
        "com.valvesoftware.Steam"
        "com.spotify.Client"
        "com.discordapp.Discord"
        "io.github.suchnsuch.Tangent"
    )

    for program in "${flatpak_programs[@]}"; do
        auxiliary_installation_flatpak "$program"
    done

    addition_extra_programs_flatpaks
    log -s "===> Flatpaks installed successfully"
}
