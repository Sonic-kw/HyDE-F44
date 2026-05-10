#!/bin/bash

# Function to check if an NVIDIA GPU is detected
nvidia_detected() {
    if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
        return 0
    else
        return 1
    fi
}

# Enable the solopasha/hyprland COPR repository
sudo dnf copr enable -y solopasha/hyprland

if nvidia_detected; then
    # Install hyprland-nvidia-git and nvidia automatically if an NVIDIA GPU is detected
    sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
   
fi
sudo dnf install -y hyprland cliphist xdg-desktop-portal-hyprland swww grimblast hyprlang uwsm

# --- Fedora 44 fix: DRM seat handover delay ---
# After SDDM's KWin Wayland greeter releases the DRM seat, logind needs a moment
# to complete the TakeDevice() handover. Without this sleep, aquamarine fails with
# "no allocator available" and Hyprland crashes immediately on session start.
sudo tee /usr/local/bin/hyprland-wait > /dev/null << 'EOF'
#!/bin/bash
# Wait for logind to finish handing the DRM seat from the SDDM KWin greeter
# to this user session. Without this, aquamarine fails with "no allocator available"
# because TakeDevice() is called before the seat switch is complete.
sleep 2
exec /usr/bin/start-hyprland "$@"
EOF
sudo chmod +x /usr/local/bin/hyprland-wait

# Copy the desktop session file to /usr/local so it survives hyprland package updates,
# then point Exec to the wrapper.
sudo mkdir -p /usr/local/share/wayland-sessions
sudo cp /usr/share/wayland-sessions/hyprland.desktop /usr/local/share/wayland-sessions/hyprland.desktop
sudo sed -i 's|^Exec=.*|Exec=/usr/local/bin/hyprland-wait|' /usr/local/share/wayland-sessions/hyprland.desktop

echo "[hyprland-wait] DRM seat fix installed."
echo "[uwsm] After reboot, select 'Hyprland (uwsm-managed)' at the SDDM login screen for screen sharing support."
