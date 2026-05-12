#!/bin/bash
set -euo pipefail

# Function to install packages
install_packages() {
    sudo dnf install -y "$@"
}

# Install required packages
install_packages \
    pipewire \
    wireplumber \
    network-manager-applet \
    brightnessctl \
    qt6-qtwayland \
    dunst \
    rofi-wayland \
    swayidle \
    wlogout \
    grim \
    slurp \
    polkit-kde \
    kf6-kwallet \
    ksshaskpass \
    xdg-desktop-portal-gtk \
    ImageMagick \
    pavucontrol \
    qt6-qtbase-devel \
    ffmpegthumbs \
    qt5-qtimageformats \
    qt6-qtbase \
    kvantum \
    qt5ct \
    qt6ct \
    waybar \
    parallel \
    dolphin \
    sddm \
    firefox \
    kde-cli-tools \
    fastfetch \
    zsh

# Enable SDDM here so it autostarts on next boot even if the theme script
# (which also enables it via system_ctl.lst) is skipped or fails.
sudo systemctl enable sddm.service
