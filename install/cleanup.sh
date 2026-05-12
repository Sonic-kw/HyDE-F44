#!/bin/bash
set -euo pipefail

# Remove temp clone dirs ONLY from the HyDE-F44 repo root, never from
# whatever CWD the caller happens to be in.
SCRIPT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$SCRIPT_DIR"

for d in Hyprland swww xdg-desktop-portal-hyprland swappy wl-clipboard \
         pokemon-colorscripts nwg-look cliphist hyprland-hyprdots-files; do
    [ -d "$d" ] && rm -rf -- "$d"
done
