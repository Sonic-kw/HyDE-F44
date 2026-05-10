#!/bin/bash

# Apply HyDE theme configs from this repo's Theme/Scripts directory.
# The configs (Theme/Configs/) already include all user customizations and
# Fedora 44 / Hyprland 0.54+ fixes — no external clone needed.

SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"

cd "$SCRIPT_DIR/Theme/Scripts" || { echo "ERROR: Theme/Scripts not found"; exit 1; }

./install.sh

echo "Installation completed successfully."
