#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Set graphical.target FIRST so a partial install still boots to a DM if SDDM
# is later enabled. Doing this last meant any earlier failure left the system
# on multi-user.target → no greeter on boot.
echo "[systemd] Setting default boot target to graphical.target..."
sudo systemctl set-default graphical.target

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

echo ""
echo "========================================="
echo "Installation complete. Please reboot."
echo "At the SDDM login screen select 'Hyprland' (or 'Hyprland (uwsm-managed)' if uwsm session preferred)."
echo "========================================="
