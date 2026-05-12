#!/bin/bash
#|---/ /+---------------------------+---/ /|#
#|--/ /-| Script to configure shell |--/ /-|#
#|-/ /--| Prasanth Rangan           |-/ /--|#
#|/ /---+---------------------------+/ /---|#

scrDir=$(dirname "$(realpath "$0")")
source "${scrDir}/global_fn.sh"
if [ $? -ne 0 ]; then
    echo "Error: unable to source global_fn.sh..."
    exit 1
fi

if chk_list "myShell" "${shlList[@]}"; then
    echo -e "\033[0;32m[SHELL]\033[0m detected // ${myShell}"
else
    # Non-fatal: bash works fine as the default; the user can `chsh` later.
    # Aborting here used to silently break the SDDM service-enable step in
    # the parent install.sh (set -e propagates through sourced global_fn.sh).
    echo -e "\033[0;33m[SHELL]\033[0m WARNING: none of [${shlList[*]}] installed — skipping shell setup"
    exit 0
fi

# add zsh plugins
# Fedora has no oh-my-zsh rpm (the Arch 'oh-my-zsh-git' check from upstream
# always failed here). Install OMZ via the official unattended script into
# $HOME/.oh-my-zsh and manage plugins/themes from there. --keep-zshrc keeps
# the .zshrc this script already deployed.
if pkg_installed zsh; then
    ZSH_DIR="${ZSH:-$HOME/.oh-my-zsh}"
    Zsh_rc="${ZDOTDIR:-$HOME}/.zshrc"

    if [ ! -f "${ZSH_DIR}/oh-my-zsh.sh" ]; then
        echo -e "\033[0;32m[SHELL]\033[0m installing oh-my-zsh into ${ZSH_DIR}..."
        RUNZSH=no CHSH=no KEEP_ZSHRC=yes sh -c \
            "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" \
            "" --unattended --keep-zshrc
    else
        echo -e "\033[0;33m[SKIP]\033[0m oh-my-zsh already installed..."
    fi

    Zsh_Custom="${ZSH_CUSTOM:-${ZSH_DIR}/custom}"
    Zsh_Plugins="${Zsh_Custom}/plugins"
    Zsh_Themes="${Zsh_Custom}/themes"
    Fix_Completion=""

    # powerlevel10k theme (referenced by the deployed .zshrc / .p10k.zsh).
    if [ ! -d "${Zsh_Themes}/powerlevel10k" ]; then
        echo -e "\033[0;32m[SHELL]\033[0m cloning powerlevel10k..."
        git clone --depth=1 https://github.com/romkatv/powerlevel10k.git \
            "${Zsh_Themes}/powerlevel10k"
    fi

    # Clone plugins from restore_zsh.lst into the user-owned custom dir
    # (no sudo — OMZ lives in $HOME).
    while read -r r_plugin; do
        z_plugin=$(echo "${r_plugin}" | awk -F '/' '{print $NF}')
        if [ "${r_plugin:0:4}" == "http" ] && [ ! -d "${Zsh_Plugins}/${z_plugin}" ]; then
            git clone --depth=1 "${r_plugin}" "${Zsh_Plugins}/${z_plugin}"
        fi
        if [ "${z_plugin}" == "zsh-completions" ] && ! grep -q 'fpath+=.*plugins/zsh-completions/src' "${Zsh_rc}" 2>/dev/null; then
            Fix_Completion='\nfpath+=${ZSH_CUSTOM:-${ZSH:-$HOME/.oh-my-zsh}/custom}/plugins/zsh-completions/src'
        else
            [ -z "${z_plugin}" ] || w_plugin+=" ${z_plugin}"
        fi
    done < <(cut -d '#' -f 1 "${scrDir}/restore_zsh.lst" | sed 's/ //g')

    if [ -f "${Zsh_rc}" ]; then
        echo -e "\033[0;32m[SHELL]\033[0m setting plugins=(${w_plugin} ) in ${Zsh_rc}"
        sed -i "/^plugins=/c\plugins=(${w_plugin} )${Fix_Completion}" "${Zsh_rc}"
    fi
fi

# set shell
if [[ "$(grep "/${USER}:" /etc/passwd | awk -F '/' '{print $NF}')" != "${myShell}" ]]; then
    echo -e "\033[0;32m[SHELL]\033[0m changing shell to ${myShell}..."
    chsh -s "$(which "${myShell}")"
else
    echo -e "\033[0;33m[SKIP]\033[0m ${myShell} is already set as shell..."
fi
