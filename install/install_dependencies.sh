#!/bin/bash
set -euo pipefail

# Function to install packages
install_packages() {
    sudo dnf install -y "$@"
}

# Install required packages.
# 'iwl*' must be quoted — unquoted it expands against CWD before dnf sees it.
install_packages \
    wl-clipboard \
    go \
    gtk3-devel \
    xdg-utils \
    swappy \
    rust \
    cargo \
    alsa-ucm \
    alsa-firmware \
    alsa-sof-firmware \
    google-noto-emoji-fonts \
    google-noto-emoji-color-fonts \
    pamixer \
    bluez \
    bluez-tools \
    blueman \
    python3-cairo \
    NetworkManager-wifi \
    'iwl*' \
    lm_sensors \
    cava \
    polkit-qt6-1 \
    lsd \
    grimblast \
    pipx

export PATH=$PATH:/usr/local/go/bin

# RPM Fusion (idempotent — dnf re-runs are no-ops once installed)
sudo dnf install -y \
            "https://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm"
sudo dnf install -y \
            "https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm"

# Google Chrome (skip re-add if already installed)
if ! rpm -q --quiet google-chrome-stable; then
    sudo dnf install -y fedora-workstation-repositories
    sudo dnf config-manager setopt google-chrome.enabled=1 2>/dev/null \
        || sudo dnf config-manager --set-enabled google-chrome
    sudo dnf install -y google-chrome-stable
fi

# Visual Studio Code (skip re-add if already installed)
if ! rpm -q --quiet code; then
    sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
    sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
    sudo dnf install -y code
fi

pipx install --force hyprshade
