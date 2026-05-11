#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

run_step() {
    local script="$1"
    echo ""
    echo "========================================="
    echo "Running: $script"
    echo "========================================="
    bash "$SCRIPT_DIR/$script"
}

run_step install_dependencies.sh
run_step install_hyprland.sh
#run_step install_cliphist.sh
# run_step install_go.sh
run_step install_nwg-look.sh
run_step install_pokemon-colorscripts.sh
run_step install_apps.sh
run_step install_themes.sh
run_step cleanup.sh

# Without graphical.target SDDM never starts on boot regardless of being enabled.
echo ""
echo "[systemd] Setting default boot target to graphical.target..."
sudo systemctl set-default graphical.target

echo ""
echo "========================================="
echo "Installation complete. Please reboot."
echo "At the SDDM login screen select: Hyprland (uwsm-managed)"
echo "========================================="
