#!/usr/bin/env bash
. scripts/log_function.sh

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
    fi

    if [[ -z "$rpm_nonfree_return" ]]; then
        log -i "===> Install Non-Free RPM Packages..." &&
        sudo dnf install \
            https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm \
            -y
        log -s "===> Successfully Installed RPM Non-Free Packages"
    fi
}
