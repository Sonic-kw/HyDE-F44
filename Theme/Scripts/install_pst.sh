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

        # Theme selection. The historical Candy / Corners tarballs in
        # Source/arcs/ are Qt5-era QML and crash sddm-greeter-qt6 (Qt6) on
        # F44. We now pull Qt6-native community forks at install time instead
        # of shipping the broken tarballs:
        #   Candy   → inviter42/sddm-anime-tactical (Sugar Candy aesthetic, Qt6)
        #   Corners → Silzinc/sddm-theme-corners    (Corners fork, Qt6-migrated)
        # breeze remains the safe default. Override with $SDDM_THEME=Candy|Corners|breeze.
        if [ -n "${use_default:-}" ] || [ ! -t 0 ]; then
            sddmopt="${SDDM_THEME:-3}"
            echo " :: Using ${sddmopt} (non-interactive)"
        else
            echo -e "Select sddm theme:\n[1] Candy (Qt6, anime-tactical fork)\n[2] Corners (Qt6, Silzinc fork)\n[3] breeze (stock) [default]"
            read -p " :: Enter option number : " sddmopt
        fi

        case $sddmopt in
        1|Candy)    sddmtheme="Candy" ;;
        2|Corners)  sddmtheme="Corners" ;;
        *)          sddmtheme="breeze" ;;
        esac

        sudo touch /etc/sddm.conf.d/kde_settings.conf
        sudo cp /etc/sddm.conf.d/kde_settings.conf /etc/sddm.conf.d/kde_settings.t2.bkp

        case "$sddmtheme" in
        breeze)
            sudo tee /etc/sddm.conf.d/kde_settings.conf > /dev/null <<'KSEOF'
[Theme]
Current=breeze

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
KSEOF
            ;;
        Corners)
            tmpdir=$(mktemp -d)
            git clone --depth=1 https://github.com/Silzinc/sddm-theme-corners.git "${tmpdir}"
            sudo rm -rf /usr/share/sddm/themes/Corners
            sudo mkdir -p /usr/share/sddm/themes/Corners
            sudo cp -r "${tmpdir}/corners/." /usr/share/sddm/themes/Corners/
            rm -rf "${tmpdir}"
            sudo tee /etc/sddm.conf.d/kde_settings.conf > /dev/null <<'KSEOF'
[Theme]
Current=Corners

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
KSEOF
            ;;
        Candy)
            tmpdir=$(mktemp -d)
            git clone --depth=1 https://github.com/inviter42/sddm-anime-tactical.git "${tmpdir}"
            sudo rm -rf /usr/share/sddm/themes/Candy
            sudo mkdir -p /usr/share/sddm/themes/Candy
            sudo cp -r "${tmpdir}/." /usr/share/sddm/themes/Candy/
            sudo rm -rf /usr/share/sddm/themes/Candy/.git \
                        /usr/share/sddm/themes/Candy/Previews \
                        /usr/share/sddm/themes/Candy/CHANGELOG.md \
                        /usr/share/sddm/themes/Candy/COPYING \
                        /usr/share/sddm/themes/Candy/AUTHORS
            rm -rf "${tmpdir}"
            sudo tee /etc/sddm.conf.d/kde_settings.conf > /dev/null <<'KSEOF'
[Theme]
Current=Candy

[General]
HaltCommand=/usr/bin/systemctl poweroff
RebootCommand=/usr/bin/systemctl reboot
KSEOF
            ;;
        esac
    else
        echo -e "\033[0;33m[SKIP]\033[0m sddm is already configured..."
    fi

    if [ ! -f /usr/share/sddm/faces/${USER}.face.icon ] && [ -f ${cloneDir}/Source/misc/${USER}.face.icon ]; then
        sudo cp ${cloneDir}/Source/misc/${USER}.face.icon /usr/share/sddm/faces/
        echo -e "\033[0;32m[DISPLAYMANAGER]\033[0m avatar set for ${USER}..."
    fi

    # The previous /etc/sddm.conf.d/fedora44-wayland.conf drop-in (forcing the
    # kwin_wayland-hosted greeter) is intentionally NOT written here. On F44 it
    # crashed sddm-greeter-qt6 in a tight loop (exit 4) even with virtio-gpu
    # and virgl. Stock X11 greeter behavior is reliable; revisit if upstream
    # SDDM ships a stable wayland greeter mode.
    sudo rm -f /etc/sddm.conf.d/fedora44-wayland.conf

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
