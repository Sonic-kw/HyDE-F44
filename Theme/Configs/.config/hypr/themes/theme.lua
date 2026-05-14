os.execute("gsettings set org.gnome.desktop.interface icon-theme 'Tela-circle-grey'")
os.execute("gsettings set org.gnome.desktop.interface gtk-theme 'Graphite-Mono'")
os.execute("gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'")

hl.config({
    general = {
        gaps_in          = 8,
        gaps_out         = 14,
        border_size      = 3,
        col = {
            active_border   = "rgba(d9d9d9ff) rgba(a6a6a6ff) 45",
            inactive_border = "rgba(404040cc) rgba(262626cc) 45",
        },
        layout           = "dwindle",
        resize_on_border = true,
    },
    group = {
        col = {
            border_active          = "rgba(d9d9d9ff) rgba(a6a6a6ff) 45",
            border_inactive        = "rgba(404040cc) rgba(262626cc) 45",
            border_locked_active   = "rgba(d9d9d9ff) rgba(a6a6a6ff) 45",
            border_locked_inactive = "rgba(404040cc) rgba(262626cc) 45",
        },
    },
    decoration = {
        rounding = 0,
        shadow = {
            enabled      = true,
            offset       = "2 2",
            range        = 15,
            render_power = 2,
            color        = "0x44FFFFFF",
        },
        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
            xray              = false,
        },
    },
})

hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
