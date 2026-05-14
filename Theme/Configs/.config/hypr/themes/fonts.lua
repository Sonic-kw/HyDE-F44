-- cursor
os.execute("hyprctl setcursor Bibata-Modern-Ice 20")
os.execute("gsettings set org.gnome.desktop.interface cursor-theme 'Bibata-Modern-Ice'")
os.execute("gsettings set org.gnome.desktop.interface cursor-size 20")

-- fonts
os.execute("gsettings set org.gnome.desktop.interface font-name 'Cantarell 10'")
os.execute("gsettings set org.gnome.desktop.interface document-font-name 'Cantarell 10'")
os.execute("gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font Mono 9'")
os.execute("gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'")
os.execute("gsettings set org.gnome.desktop.interface font-hinting 'full'")
