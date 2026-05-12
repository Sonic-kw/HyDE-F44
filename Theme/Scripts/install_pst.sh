#!/bin/bash
#|---/ /+--------------------------------------+---/ /|#
#|--/ /-| Script to apply post install configs |--/ /-|#
#|-/ /--| Prasanth Rangan                      |-/ /--|#
#|/ /---+--------------------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

# sddm
if pkg_installed sddm; then

    echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m detected // sddm"
    if [ ! -d /etc/sddm.conf.d ]; then
        sudo mkdir -p /etc/sddm.conf.d
    fi

    if [ ! -f /etc/sddm.conf.d/kde_settings.t2.bkp ]; then
        echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m configuring sddm..."

        # Non-interactive default: honor $use_default (-d flag), $SDDM_THEME env,
        # or fall back to Corners when stdin isn't a TTY (headless / unattended).
        if [ -n "${use_default:-}" ] || [ ! -t 0 ]; then
            sddmopt="${SDDM_THEME:-2}"
            echo " :: Using ${sddmopt} (non-interactive)"
        else
            echo -e "Select sddm theme:\n[1] Candy\n[2] Corners"
            read -p " :: Enter option number : " sddmopt
        fi

        case $sddmopt in
        1|Candy)   sddmtheme="Candy" ;;
        *)         sddmtheme="Corners" ;;
        esac

        sudo tar -xzf ${cloneDir}/Source/arcs/Sddm_${sddmtheme}.tar.gz -C /usr/share/sddm/themes/
        sudo touch /etc/sddm.conf.d/kde_settings.conf
        sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.t2.bkp
        sudo cp /usr/share/sddm/themes/${sddmtheme}/kde_settings.conf /etc/sddm.conf.d/
    else
        echo -e "\033[0;33m[SKIP]\033[0m sddm is already configured..."
    fi

    if [ ! -f /usr/share/sddm/faces/${USER}.face.icon ] && [ -f ${cloneDir}/Source/misc/${USER}.face.icon ]; then
        sudo cp ${cloneDir}/Source/misc/${USER}.face.icon /usr/share/sddm/faces/
        echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m avatar set for ${USER}..."
    fi

    # Fedora 44 fix: run SDDM greeter in Wayland mode to prevent random crashes.
    # By default SDDM uses X11 greeter which fails on Wayland-native setups.
    # This drop-in makes SDDM use kwin_wayland as the greeter compositor.
    if [ ! -f /etc/sddm.conf.d/fedora44-wayland.conf ]; then
        echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m applying Fedora 44 Wayland greeter fix..."
        # NOTE: --inputmethod takes a binary name / path. 'plasma-keyboard'
        # is not a real F44 binary; use qtvirtualkeyboard (or omit entirely).
        sudo tee /etc/sddm.conf.d/fedora44-wayland.conf > /dev/null << 'SDDMEOF'
[General]
DisplayServer=wayland
GreeterEnvironment=QT_WAYLAND_SHELL_INTEGRATION=layer-shell
InputMethod=

[Wayland]
CompositorCommand=kwin_wayland --no-global-shortcuts --no-lockscreen --inputmethod qtvirtualkeyboard --locale1
SDDMEOF
        echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m Wayland greeter fix applied."
    else
        echo -e "\033[0;33m[SKIP]\033[0m Fedora 44 Wayland fix already in place..."
    fi

else
    echo -e "\033[0;33m[WARNING]\033[0m sddm is not installed..."
fi

# Tela-circle icon theme (required by all HyDE themes: grey, purple, green, etc.)
tela_marker="${HOME}/.local/share/icons/Tela-circle/index.theme"
if [ ! -f "${tela_marker}" ]; then
    echo -e "\033[0;32m[ICONS]\033[0m installing Tela-circle icon theme..."
    tela_tmp=$(mktemp -d)
    git clone --depth=1 https://github.com/vinceliuice/Tela-circle-icon-theme.git "${tela_tmp}"
    bash "${tela_tmp}/install.sh" -a
    rm -rf "${tela_tmp}"
    echo -e "\033[0;32m[ICONS]\033[0m Tela-circle icon theme installed."
else
    echo -e "\033[0;33m[SKIP]\033[0m Tela-circle icon theme already installed..."
fi

# dolphin
if pkg_installed dolphin && pkg_installed xdg-utils; then

    echo -e "\033[0;32m[FILEMANAGER]\033[0m detected // dolphin"
    xdg-mime default org.kde.dolphin.desktop inode/directory
    echo -e "\033[0;32m[FILEMANAGER]\033[0m setting" `xdg-mime query default "inode/directory"` "as default file explorer..."

else
    echo -e "\033[0;33m[WARNING]\033[0m dolphin is not installed..."
fi

# shell
"${scrDir}/restore_shl.sh"

# flatpak
if ! pkg_installed flatpak; then

    echo -e "\033[0;32m[FLATPAK]\033[0m flatpak application list..."
    awk -F '#' '$1 != "" {print "["++count"]", $1}' "${scrDir}/.extra/custom_flat.lst"
    prompt_timer 60 "Install these flatpaks? [Y/n]"
    fpkopt=${promptIn,,}

    if [ "${fpkopt}" = "y" ]; then
        echo -e "\033[0;32m[FLATPAK]\033[0m intalling flatpaks..."
        "${scrDir}/.extra/install_fpk.sh"
    else
        echo -e "\033[0;33m[SKIP]\033[0m intalling flatpaks..."
    fi

else
    echo -e "\033[0;33m[SKIP]\033[0m flatpak is already installed..."
fi
