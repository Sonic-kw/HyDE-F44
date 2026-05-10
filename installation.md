# Installation Guide

## Requirements

- Fedora 44 (minimal or any spin)
- Internet connection
- A user account with `sudo` privileges

---

## Quick Install

```shell
sudo dnf install git
git clone https://github.com/Sonic-kw/HyDE-F44.git
cd HyDE-F44/install
./install_all.sh
```

Reboot after the script completes.

---

## What `install_all.sh` Does

The script runs the following steps in order:

| Step | Script | Description |
| :-- | :-- | :-- |
| 1 | `install_dependencies.sh` | Core libs, audio, Bluetooth, fonts, dev tools |
| 2 | `install_hyprland.sh` | Hyprland via COPR + Fedora 44 DRM seat fix |
| 3 | `install_nwg-look.sh` | GTK theming tool via COPR |
| 4 | `install_pokemon-colorscripts.sh` | Terminal Pokémon sprites |
| 5 | `install_apps.sh` | Status bar, launcher, file manager, VS Code, Chrome |
| 6 | `install_themes.sh` | HyDE theme configs, scripts, and user dotfiles |
| 7 | `cleanup.sh` | Removes temporary build files |

---

## COPR Repositories Used

The following COPR repositories are enabled automatically:

| COPR | Provides |
| :-- | :-- |
| `solopasha/hyprland` | hyprland, hyprlock, xdg-desktop-portal-hyprland, grimblast, swww |
| `tofik/nwg-shell` | nwg-look |

---

## Fedora 44–Specific Fixes (Applied Automatically)

### 1. SDDM Wayland Greeter

The script writes `/etc/sddm.conf.d/fedora44-wayland.conf`, which switches SDDM to use a
KWin Wayland compositor as the greeter instead of the default X11 greeter. Without this,
SDDM can crash randomly on Fedora 44 Wayland-native setups.

### 2. Hyprland DRM Seat Handover Delay

A wrapper script `/usr/local/bin/hyprland-wait` is installed. It sleeps 2 seconds before
launching Hyprland, giving logind time to complete the DRM seat handover from the SDDM
KWin greeter. Without this delay, Hyprland's aquamarine backend fails with
`no allocator available` and the session crashes immediately.

The wrapper is placed in `/usr/local/share/wayland-sessions/hyprland.desktop` so it
survives hyprland package updates (overrides `/usr/share/wayland-sessions/`).

### 3. Screen Sharing (uwsm + hyprlang)

`uwsm` (Universal Wayland Session Manager) and `hyprlang` are installed automatically.
uwsm launches Hyprland as a proper systemd-managed session, enabling screen sharing in
apps like Vesktop/Discord. `hyprlang` is a required shared library for
`xdg-desktop-portal-hyprland` that is not automatically pulled as a dependency on Fedora 44.

**After install, select "Hyprland (uwsm-managed)" at the SDDM login screen** — not the
plain "Hyprland" session. The session file is provided by the `uwsm` package at
`/usr/share/wayland-sessions/hyprland-uwsm.desktop`.

---

## NVIDIA GPUs

`install_hyprland.sh` detects NVIDIA hardware automatically via `lspci`. If found, it
installs `akmod-nvidia` and `xorg-x11-drv-nvidia-cuda` before installing Hyprland.

The akmod build can take several minutes after install. Do not reboot until the kernel
module is fully built — check with:

```shell
modinfo -F version nvidia
```

---

## Manual / Per-Script Install

If you prefer to run steps individually:

```shell
cd HyDE-F44/install

# 1. Core dependencies
sudo bash install_dependencies.sh

# 2. Hyprland + DRM seat fix (includes hyprlock)
sudo bash install_hyprland.sh

# 3. GTK theming
sudo bash install_nwg-look.sh

# 4. Pokemon colorscripts (terminal fun)
sudo bash install_pokemon-colorscripts.sh

# 5. Applications (waybar, rofi, dolphin, VS Code, Chrome)
sudo bash install_apps.sh

# 6. HyDE themes and dotfiles
sudo bash install_themes.sh

# 8. Cleanup
sudo bash cleanup.sh
```

---

## After Install

1. **Reboot** — required for SDDM, Hyprland session, and NVIDIA modules (if applicable)
2. At the SDDM login screen, select the **Hyprland (uwsm-managed)** session from the session menu
3. Log in — Hyprland will start with the default theme (Catppuccin-Mocha)

To change theme: `Super + Shift + T`  
To change wallpaper: `Super + Alt + →` / `Super + Alt + ←`

---

## Uninstall / Restore

There is no automated uninstall script. To revert:

- Restore your previous configs from backup (`~/.config/` and `~/.local/`)
- Remove the SDDM drop-in: `sudo rm /etc/sddm.conf.d/fedora44-wayland.conf`
- Remove the Hyprland wrapper: `sudo rm /usr/local/bin/hyprland-wait /usr/local/share/wayland-sessions/hyprland.desktop`

---

> **Warning**
>
> Always back up your existing `~/.config/` before running any install scripts.
> This project is provided as-is. The author takes no responsibility for data loss or system instability.
