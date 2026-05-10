#!/bin/bash
# Restart portals via systemd (requires uwsm / graphical-session.target active)
systemctl --user restart xdg-desktop-portal-hyprland
systemctl --user restart xdg-desktop-portal
