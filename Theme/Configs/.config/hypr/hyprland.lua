local home    = os.getenv("HOME")
local scrPath = home .. "/.local/share/bin"

-- ── Monitors ──────────────────────────────────────────────────────────
hl.monitor({ output = "eDP-1", mode = "preferred", position = "auto", scale = 1 })
hl.monitor({ output = "DP-1",  mode = "preferred", position = "auto", scale = 1 })

-- ── Cursor ────────────────────────────────────────────────────────────
hl.config({ cursor = { no_hardware_cursors = 2 } })  -- 2 = auto (disable on nvidia/tearing)

-- ── Autostart (exec-once) ─────────────────────────────────────────────
hl.on("hyprland.start", function()
    hl.dispatch(hl.dsp.exec_cmd("dbus-update-activation-environment --systemd --all"))
    hl.dispatch(hl.dsp.exec_cmd("/usr/bin/kwalletd6"))
    hl.dispatch(hl.dsp.exec_cmd(scrPath .. "/polkitkdeauth.sh"))
    hl.dispatch(hl.dsp.exec_cmd("waybar --config " .. home .. "/.config/waybar/config.jsonc --style " .. home .. "/.config/waybar/style.css"))
    hl.dispatch(hl.dsp.exec_cmd("blueman-applet"))
    hl.dispatch(hl.dsp.exec_cmd("udiskie --no-automount --smart-tray"))
    hl.dispatch(hl.dsp.exec_cmd("nm-applet --indicator"))
    hl.dispatch(hl.dsp.exec_cmd("dunst"))
    hl.dispatch(hl.dsp.exec_cmd("wl-paste --type text --watch cliphist store"))
    hl.dispatch(hl.dsp.exec_cmd("wl-paste --type image --watch cliphist store"))
    hl.dispatch(hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh"))
    hl.dispatch(hl.dsp.exec_cmd(scrPath .. "/batterynotify.sh"))
end)

-- ── Environment variables ─────────────────────────────────────────────
hl.env("PATH",                          os.getenv("PATH") .. ":" .. scrPath)
hl.env("XDG_CURRENT_DESKTOP",           "Hyprland")
hl.env("XDG_SESSION_TYPE",              "wayland")
hl.env("XDG_SESSION_DESKTOP",           "Hyprland")
hl.env("QT_QPA_PLATFORM",               "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME",          "kde")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR",   "1")
hl.env("MOZ_ENABLE_WAYLAND",            "1")
hl.env("GDK_SCALE",                     "1")

-- ── Input ─────────────────────────────────────────────────────────────
hl.config({
    input = {
        kb_layout     = "pl",
        follow_mouse  = 1,
        sensitivity   = -0.3,
        force_no_accel = false,
        accel_profile = "flat",
        touchpad      = { natural_scroll = true },
    },
})

-- ── Per-device touchpad override ──────────────────────────────────────
hl.device({
    name          = "synps/2-synaptics-touchpad",
    sensitivity   = -0.3,
    accel_profile = "flat",
})

-- ── Gesture ───────────────────────────────────────────────────────────
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- ── Layouts ───────────────────────────────────────────────────────────
hl.config({
    dwindle = { pseudotile = true, preserve_split = true },
    master  = { new_status = "master" },
})

-- ── Misc ──────────────────────────────────────────────────────────────
hl.config({
    misc = {
        vrr                      = 0,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        force_default_wallpaper  = 0,
    },
    xwayland = { force_zero_scaling = true },
})

-- ── Sub-files ─────────────────────────────────────────────────────────
dofile(home .. "/.config/hypr/animations.lua")
dofile(home .. "/.config/hypr/keybindings.lua")
dofile(home .. "/.config/hypr/windowrules.lua")
dofile(home .. "/.config/hypr/themes/common.lua")
dofile(home .. "/.config/hypr/themes/theme.lua")
dofile(home .. "/.config/hypr/themes/colors.lua")
dofile(home .. "/.config/hypr/monitors.lua")
dofile(home .. "/.config/hypr/userprefs.lua")

-- ── Nvidia (auto-appended by install script if needed) ────────────────
-- dofile(home .. "/.config/hypr/nvidia.lua")
