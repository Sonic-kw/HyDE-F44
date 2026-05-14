local mainMod = "SUPER"
local home    = os.getenv("HOME")
local scrPath = home .. "/.local/share/bin"
local term    = "kitty"
local editor  = "code --ozone-platform-hint=wayland --disable-gpu"
local file    = "dolphin"
local browser = "google-chrome"

-- ── Window / session ──────────────────────────────────────────────────
hl.bind(mainMod .. " + Q",          hl.dsp.window.close(),                                  { description = "Window: Close" })
hl.bind("ALT + F4",                 hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"),        { description = "Window: Smart-close (steam-aware)" })
hl.bind(mainMod .. " + Delete",     hl.dsp.exit(),                                          { description = "Session: Exit Hyprland" })
hl.bind(mainMod .. " + W",          hl.dsp.window.float({ action = "toggle" }),             { description = "Window: Toggle float" })
hl.bind(mainMod .. " + G",          hl.dsp.group.toggle(),                                  { description = "Window: Toggle group (tabbed)" })
hl.bind("ALT + Return",             hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }), { description = "Window: Toggle fullscreen" })
hl.bind(mainMod .. " + L",          hl.dsp.exec_cmd("hyprlock"),                            { locked = true, description = "Session: Lock" })
hl.bind(mainMod .. " + SHIFT + F",  hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"),            { description = "Window: Pin (always on top)" })
hl.bind(mainMod .. " + Backspace",  hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"),         { description = "Session: Logout menu" })
hl.bind("CTRL + ALT + W",           hl.dsp.exec_cmd("killall waybar || waybar"),            { description = "Bar: Toggle waybar" })

-- ── App shortcuts ─────────────────────────────────────────────────────
hl.bind(mainMod .. " + T",          hl.dsp.exec_cmd(term),                                  { description = "App: Terminal" })
hl.bind(mainMod .. " + E",          hl.dsp.exec_cmd(file),                                  { description = "App: File manager" })
hl.bind(mainMod .. " + C",          hl.dsp.exec_cmd(editor),                                { description = "App: Code editor" })
hl.bind(mainMod .. " + B",          hl.dsp.exec_cmd(browser),                               { description = "App: Browser" })
hl.bind("CTRL + SHIFT + Escape",    hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"),         { description = "App: System monitor" })

-- ── Rofi menus ────────────────────────────────────────────────────────
hl.bind(mainMod .. " + A",          hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"), { description = "Rofi: App launcher" })
hl.bind(mainMod .. " + Tab",        hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh w"), { description = "Rofi: Window switcher" })
hl.bind(mainMod .. " + SHIFT + E",  hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"), { description = "Rofi: File search" })

-- ── Audio (locked = works on lockscreen) ──────────────────────────────
hl.bind("F10",                      hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"),   { locked = true, description = "Audio: Toggle mute" })
hl.bind("F11",                      hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),   { locked = true, repeating = true, description = "Audio: Volume down" })
hl.bind("F12",                      hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),   { locked = true, repeating = true, description = "Audio: Volume up" })
hl.bind("XF86AudioMute",            hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"),   { locked = true })
hl.bind("XF86AudioMicMute",         hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"),   { locked = true, description = "Audio: Toggle mic mute" })
hl.bind("XF86AudioLowerVolume",     hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"),   { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",     hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"),   { locked = true, repeating = true })

-- ── Media ─────────────────────────────────────────────────────────────
hl.bind("XF86AudioPlay",            hl.dsp.exec_cmd("playerctl play-pause"),                { locked = true, description = "Media: Play/pause" })
hl.bind("XF86AudioPause",           hl.dsp.exec_cmd("playerctl play-pause"),                { locked = true })
hl.bind("XF86AudioNext",            hl.dsp.exec_cmd("playerctl next"),                      { locked = true, description = "Media: Next track" })
hl.bind("XF86AudioPrev",            hl.dsp.exec_cmd("playerctl previous"),                  { locked = true, description = "Media: Previous track" })

-- ── Brightness ────────────────────────────────────────────────────────
hl.bind("XF86MonBrightnessUp",      hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"),  { locked = true, repeating = true, description = "Brightness: Up" })
hl.bind("XF86MonBrightnessDown",    hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"),  { locked = true, repeating = true, description = "Brightness: Down" })

-- ── Screenshots ───────────────────────────────────────────────────────
hl.bind(mainMod .. " + P",          hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"),         { description = "Screenshot: Region snip" })
hl.bind(mainMod .. " + CTRL + P",   hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"),        { description = "Screenshot: Region freeze" })
hl.bind(mainMod .. " + ALT + P",    hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"),         { description = "Screenshot: Monitor" })
hl.bind("Print",                    hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"),         { description = "Screenshot: Full screen" })

-- ── Custom scripts ────────────────────────────────────────────────────
hl.bind(mainMod .. " + ALT + G",        hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"),         { description = "Misc: Toggle game mode" })
hl.bind(mainMod .. " + ALT + Right",    hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n"),  { description = "Wallpaper: Next" })
hl.bind(mainMod .. " + ALT + Left",     hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p"),  { description = "Wallpaper: Previous" })
hl.bind(mainMod .. " + ALT + Up",       hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"),    { description = "Bar: Next layout" })
hl.bind(mainMod .. " + ALT + Down",     hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"),    { description = "Bar: Previous layout" })
hl.bind(mainMod .. " + SHIFT + R",      hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"), { description = "Theme: Toggle wallbash mode" })
hl.bind(mainMod .. " + SHIFT + T",      hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"),       { description = "Theme: Selector" })
hl.bind(mainMod .. " + SHIFT + A",      hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"),        { description = "Rofi: Style selector" })
hl.bind(mainMod .. " + SHIFT + W",      hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/swwwallselect.sh"),     { description = "Wallpaper: Selector" })
hl.bind(mainMod .. " + V",              hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh c"),        { description = "Clipboard: History" })
hl.bind(mainMod .. " + K",              hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"),   { description = "Input: Cycle keyboard layout" })

-- ── Window focus ──────────────────────────────────────────────────────
hl.bind(mainMod .. " + Left",       hl.dsp.focus({ direction = "l" }),                      { description = "Focus: Left" })
hl.bind(mainMod .. " + Right",      hl.dsp.focus({ direction = "r" }),                      { description = "Focus: Right" })
hl.bind(mainMod .. " + Up",         hl.dsp.focus({ direction = "u" }),                      { description = "Focus: Up" })
hl.bind(mainMod .. " + Down",       hl.dsp.focus({ direction = "d" }),                      { description = "Focus: Down" })
hl.bind("ALT + Tab",                hl.dsp.window.cycle_next(),                             { description = "Focus: Cycle next window" })

-- ── Switch workspaces (raw keycodes for kb_layout independence) ───────
for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind(mainMod .. " + code:" .. numberkey[i], hl.dsp.focus({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + CTRL + Right",   hl.dsp.focus({ workspace = "r+1" }),                { description = "Workspace: Next" })
hl.bind(mainMod .. " + CTRL + Left",    hl.dsp.focus({ workspace = "r-1" }),                { description = "Workspace: Previous" })
hl.bind(mainMod .. " + CTRL + Down",    hl.dsp.focus({ workspace = "empty" }),              { description = "Workspace: First empty" })

-- ── Resize windows ────────────────────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + Right",  hl.dsp.window.resize({ x =  30, y =   0, relative = true }), { repeating = true, description = "Window: Grow right" })
hl.bind(mainMod .. " + SHIFT + Left",   hl.dsp.window.resize({ x = -30, y =   0, relative = true }), { repeating = true, description = "Window: Shrink right" })
hl.bind(mainMod .. " + SHIFT + Up",     hl.dsp.window.resize({ x =   0, y = -30, relative = true }), { repeating = true, description = "Window: Shrink down" })
hl.bind(mainMod .. " + SHIFT + Down",   hl.dsp.window.resize({ x =   0, y =  30, relative = true }), { repeating = true, description = "Window: Grow down" })

-- ── Move window to workspace (raw keycodes) ───────────────────────────
for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind(mainMod .. " + SHIFT + code:" .. numberkey[i], hl.dsp.window.move({ workspace = tostring(i) }))
end
hl.bind(mainMod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }),      { description = "Window: Send to next workspace" })
hl.bind(mainMod .. " + CTRL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }),      { description = "Window: Send to previous workspace" })

-- ── Move window within workspace ──────────────────────────────────────
hl.bind(mainMod .. " + SHIFT + CTRL + Left",  hl.dsp.window.move({ direction = "l" }),      { description = "Window: Move left" })
hl.bind(mainMod .. " + SHIFT + CTRL + Right", hl.dsp.window.move({ direction = "r" }),      { description = "Window: Move right" })
hl.bind(mainMod .. " + SHIFT + CTRL + Up",    hl.dsp.window.move({ direction = "u" }),      { description = "Window: Move up" })
hl.bind(mainMod .. " + SHIFT + CTRL + Down",  hl.dsp.window.move({ direction = "d" }),      { description = "Window: Move down" })

-- ── Scroll workspaces with mouse wheel ────────────────────────────────
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- ── Mouse window move / resize ────────────────────────────────────────
hl.bind(mainMod .. " + mouse:272",  hl.dsp.window.drag(),   { mouse = true, description = "Window: Drag (LMB)" })
hl.bind(mainMod .. " + mouse:273",  hl.dsp.window.resize(), { mouse = true, description = "Window: Resize (RMB)" })
hl.bind(mainMod .. " + Z",          hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + X",          hl.dsp.window.resize(), { mouse = true })

-- ── Special workspace (scratchpad) ────────────────────────────────────
hl.bind(mainMod .. " + ALT + S",    hl.dsp.window.move({ workspace = "special", follow = false }), { description = "Window: Send to scratchpad" })
hl.bind(mainMod .. " + S",          hl.dsp.workspace.toggle_special(""),                    { description = "Workspace: Toggle scratchpad" })

-- ── Toggle split (dwindle layout) ─────────────────────────────────────
hl.bind(mainMod .. " + J",          hl.dsp.layout("togglesplit"),                           { description = "Layout: Toggle split direction" })

-- ── Move to workspace silently (no focus follow) ──────────────────────
for i = 1, 10 do
    local numberkey = { 10, 11, 12, 13, 14, 15, 16, 17, 18, 19 }
    hl.bind(mainMod .. " + ALT + code:" .. numberkey[i], hl.dsp.window.move({ workspace = tostring(i), follow = false }))
end
