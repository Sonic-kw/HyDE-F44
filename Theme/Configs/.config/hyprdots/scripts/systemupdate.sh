#!/bin/bash

# source variables
scrDir=$(dirname "$(realpath "$0")")
source "$scrDir/globalcontrol.sh"
fpk_exup="flatpak update"

# Trigger upgrade
if [ "$1" == "up" ] ; then
    trap 'pkill -RTMIN+20 waybar' EXIT
    command="
    fastfetch
    $0 upgrade
    sudo dnf upgrade
    $fpk_exup
    read -n 1 -p 'Press any key to continue...'
    "
    kitty --title systemupdate sh -c "${command}"
fi

# Check for dnf updates (Fedora — no AUR)
ofc=$(dnf check-update --quiet 2>/dev/null | grep -c '^[a-zA-Z]' || true)

# Check for flatpak updates
if pkg_installed flatpak ; then
    fpk=$(flatpak remote-ls --updates | wc -l)
    fpk_disp="\n󰏓 Flatpak $fpk"
else
    fpk=0
    fpk_disp=""
fi

# Calculate total available updates
upd=$(( ofc + fpk ))

[ "${1}" == upgrade ] && printf "[DNF]      %-10s\n[Flatpak]  %-10s\n" "$ofc" "$fpk" && exit

# Show tooltip
if [ $upd -eq 0 ] ; then
    upd="" #Remove Icon completely
    echo "{\"text\":\"$upd\", \"tooltip\":\" Packages are up to date\"}"
else
    echo "{\"text\":\"󰮯 $upd\", \"tooltip\":\"󱓽 DNF $ofc$fpk_disp\"}"
fi
