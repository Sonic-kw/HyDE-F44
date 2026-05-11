#!/bin/bash
set -e

nvidia_detected() {
    if lspci -k | grep -A 2 -E "(VGA|3D)" | grep -iq nvidia; then
        return 0
    else
        return 1
    fi
}

# Rebuild aquamarine from its SRPM against the currently-installed libdisplay-info.
# Needed when the COPR binary was compiled against libdisplay-info.so.2 but
# Fedora 44 >= libdisplay-info-0.3.0 provides libdisplay-info.so.3 (soname bump).
rebuild_aquamarine_from_srpm() {
    echo "[aquamarine] Rebuilding from SRPM against system libdisplay-info..."
    sudo dnf install -y rpm-build rpmdevtools

    local tmpdir
    tmpdir=$(mktemp -d)
    pushd "$tmpdir" > /dev/null

    dnf download --source aquamarine
    sudo dnf builddep -y aquamarine-*.src.rpm
    rpmbuild --rebuild aquamarine-*.src.rpm

    popd > /dev/null
    rm -rf "$tmpdir"

    local rpm_path
    rpm_path=$(find "$HOME/rpmbuild/RPMS/x86_64" -name "aquamarine-[0-9]*.rpm" | grep -v debug | tail -1)
    if [ -z "$rpm_path" ]; then
        echo "[aquamarine] ERROR: rebuilt RPM not found in ~/rpmbuild/RPMS/x86_64" >&2
        return 1
    fi
    sudo rpm -i "$rpm_path"
    echo "[aquamarine] Rebuilt RPM installed: $(basename "$rpm_path")"
}

sudo dnf copr enable -y solopasha/hyprland

if nvidia_detected; then
    sudo dnf install -y akmod-nvidia xorg-x11-drv-nvidia-cuda
fi

# Check whether the COPR aquamarine has the libdisplay-info soname mismatch before
# attempting the full install, to give a clear error rather than a silent failure.
if sudo dnf install -y --assumeno aquamarine 2>&1 | grep -q "libdisplay-info.so.2"; then
    echo "[aquamarine] soname mismatch: COPR package needs .so.2 but system has .so.3"
    rebuild_aquamarine_from_srpm
fi

sudo dnf install -y hyprland cliphist xdg-desktop-portal-hyprland swww grimblast hyprlang uwsm

# --- Fedora 44 fix: DRM seat handover delay ---
# After SDDM's KWin Wayland greeter releases the DRM seat, logind needs a moment
# to complete the TakeDevice() handover. Without this sleep, aquamarine fails with
# "no allocator available" and Hyprland crashes immediately on session start.
sudo tee /usr/local/bin/hyprland-wait > /dev/null << 'EOF'
#!/bin/bash
sleep 2
exec /usr/bin/start-hyprland "$@"
EOF
sudo chmod +x /usr/local/bin/hyprland-wait

sudo mkdir -p /usr/local/share/wayland-sessions
sudo cp /usr/share/wayland-sessions/hyprland.desktop /usr/local/share/wayland-sessions/hyprland.desktop
sudo sed -i 's|^Exec=.*|Exec=/usr/local/bin/hyprland-wait|' /usr/local/share/wayland-sessions/hyprland.desktop

echo "[hyprland-wait] DRM seat fix installed."
echo "[uwsm] After reboot, select 'Hyprland (uwsm-managed)' at the SDDM login screen for screen sharing support."
