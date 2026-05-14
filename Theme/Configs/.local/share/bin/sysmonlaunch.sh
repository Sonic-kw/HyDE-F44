#!/bin/bash

scrDir="$(dirname "$(realpath "$0")")"
source "${scrDir}/globalcontrol.sh"
pkgChk=("io.missioncenter.MissionCenter" "htop" "btop" "top")

for sysMon in "${!pkgChk[@]}"; do
    [ "${sysMon}" -gt 0 ] && term=$(grep '^local term' "$HOME/.config/hypr/keybindings.lua" | awk -F'"' '{print $2}')
    if pkg_installed "${pkgChk[sysMon]}" ; then
        pkill -x "${pkgChk[sysMon]}" || ${term} "${pkgChk[sysMon]}" &
        break
    fi
done

