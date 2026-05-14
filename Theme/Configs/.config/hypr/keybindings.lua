local mainMod = "SUPER"
local home    = os.getenv("HOME")
local scrPath = home .. "/.local/share/bin"
local term    = "kitty"
local editor  = "code --ozone-platform-hint=wayland --disable-gpu"
local file    = "dolphin"
local browser = "google-chrome"

-- Window / session
hl.bind(mainMod .. " + Q",              hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"))
hl.bind("ALT + F4",                     hl.dsp.exec_cmd(scrPath .. "/dontkillsteam.sh"))
hl.bind(mainMod .. " + Delete",         hl.dsp.exit())
hl.bind(mainMod .. " + W",              hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + G",             hl.dsp.group.toggle())
hl.bind("ALT + Return",                 hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind(mainMod .. " + L",             hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + SHIFT + F",     hl.dsp.exec_cmd(scrPath .. "/windowpin.sh"))
hl.bind(mainMod .. " + Backspace",     hl.dsp.exec_cmd(scrPath .. "/logoutlaunch.sh"))
hl.bind("CTRL + ALT + W",              hl.dsp.exec_cmd("killall waybar || waybar"))

-- App shortcuts
hl.bind(mainMod .. " + T",             hl.dsp.exec_cmd(term))
hl.bind(mainMod .. " + E",             hl.dsp.exec_cmd(file))
hl.bind(mainMod .. " + C",             hl.dsp.exec_cmd(editor))
hl.bind(mainMod .. " + B",             hl.dsp.exec_cmd(browser))
hl.bind("CTRL + SHIFT + Escape",       hl.dsp.exec_cmd(scrPath .. "/sysmonlaunch.sh"))

-- Rofi menus
hl.bind(mainMod .. " + A",             hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh d"))
hl.bind(mainMod .. " + Tab",           hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh w"))
hl.bind(mainMod .. " + SHIFT + E",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofilaunch.sh f"))

-- Audio (locked = works on lockscreen)
hl.bind("F10",                          hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("F11",                          hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("F12",                          hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })
hl.bind("XF86AudioMute",               hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o m"), { locked = true })
hl.bind("XF86AudioMicMute",            hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -i m"), { locked = true })
hl.bind("XF86AudioLowerVolume",        hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o d"), { locked = true, repeating = true })
hl.bind("XF86AudioRaiseVolume",        hl.dsp.exec_cmd(scrPath .. "/volumecontrol.sh -o i"), { locked = true, repeating = true })

-- Media
hl.bind("XF86AudioPlay",               hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPause",              hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext",               hl.dsp.exec_cmd("playerctl next"),        { locked = true })
hl.bind("XF86AudioPrev",               hl.dsp.exec_cmd("playerctl previous"),    { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",         hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh i"), { repeating = true })
hl.bind("XF86MonBrightnessDown",       hl.dsp.exec_cmd(scrPath .. "/brightnesscontrol.sh d"), { repeating = true })

-- Screenshots
hl.bind(mainMod .. " + P",             hl.dsp.exec_cmd(scrPath .. "/screenshot.sh s"))
hl.bind(mainMod .. " + CTRL + P",      hl.dsp.exec_cmd(scrPath .. "/screenshot.sh sf"))
hl.bind(mainMod .. " + ALT + P",       hl.dsp.exec_cmd(scrPath .. "/screenshot.sh m"))
hl.bind("Print",                        hl.dsp.exec_cmd(scrPath .. "/screenshot.sh p"))

-- Custom scripts
hl.bind(mainMod .. " + ALT + G",       hl.dsp.exec_cmd(scrPath .. "/gamemode.sh"))
hl.bind(mainMod .. " + ALT + Right",   hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -n"))
hl.bind(mainMod .. " + ALT + Left",    hl.dsp.exec_cmd(scrPath .. "/swwwallpaper.sh -p"))
hl.bind(mainMod .. " + ALT + Up",      hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh n"))
hl.bind(mainMod .. " + ALT + Down",    hl.dsp.exec_cmd(scrPath .. "/wbarconfgen.sh p"))
hl.bind(mainMod .. " + SHIFT + R",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/wallbashtoggle.sh -m"))
hl.bind(mainMod .. " + SHIFT + T",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/themeselect.sh"))
hl.bind(mainMod .. " + SHIFT + A",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/rofiselect.sh"))
hl.bind(mainMod .. " + SHIFT + W",     hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/swwwallselect.sh"))
hl.bind(mainMod .. " + V",             hl.dsp.exec_cmd("pkill -x rofi || " .. scrPath .. "/cliphist.sh c"))
hl.bind(mainMod .. " + K",             hl.dsp.exec_cmd(scrPath .. "/keyboardswitch.sh"))

-- Window focus
hl.bind(mainMod .. " + Left",          hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + Right",         hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + Up",            hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + Down",          hl.dsp.focus({ direction = "d" }))
hl.bind("ALT + Tab",                   hl.dsp.focus({ direction = "d" }))

-- Switch workspaces
hl.bind(mainMod .. " + 1",             hl.dsp.focus({ workspace = "1" }))
hl.bind(mainMod .. " + 2",             hl.dsp.focus({ workspace = "2" }))
hl.bind(mainMod .. " + 3",             hl.dsp.focus({ workspace = "3" }))
hl.bind(mainMod .. " + 4",             hl.dsp.focus({ workspace = "4" }))
hl.bind(mainMod .. " + 5",             hl.dsp.focus({ workspace = "5" }))
hl.bind(mainMod .. " + 6",             hl.dsp.focus({ workspace = "6" }))
hl.bind(mainMod .. " + 7",             hl.dsp.focus({ workspace = "7" }))
hl.bind(mainMod .. " + 8",             hl.dsp.focus({ workspace = "8" }))
hl.bind(mainMod .. " + 9",             hl.dsp.focus({ workspace = "9" }))
hl.bind(mainMod .. " + 0",             hl.dsp.focus({ workspace = "10" }))
hl.bind(mainMod .. " + CTRL + Right",  hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + Left",   hl.dsp.focus({ workspace = "r-1" }))
hl.bind(mainMod .. " + CTRL + Down",   hl.dsp.focus({ workspace = "empty" }))

-- Resize windows
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.resize({ x = 30,  y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.resize({ x = -30, y = 0,   relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.resize({ x = 0,   y = -30, relative = true }), { repeating = true })
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.resize({ x = 0,   y = 30,  relative = true }), { repeating = true })

-- Move window to workspace
hl.bind(mainMod .. " + SHIFT + 1",    hl.dsp.window.move({ workspace = "1" }))
hl.bind(mainMod .. " + SHIFT + 2",    hl.dsp.window.move({ workspace = "2" }))
hl.bind(mainMod .. " + SHIFT + 3",    hl.dsp.window.move({ workspace = "3" }))
hl.bind(mainMod .. " + SHIFT + 4",    hl.dsp.window.move({ workspace = "4" }))
hl.bind(mainMod .. " + SHIFT + 5",    hl.dsp.window.move({ workspace = "5" }))
hl.bind(mainMod .. " + SHIFT + 6",    hl.dsp.window.move({ workspace = "6" }))
hl.bind(mainMod .. " + SHIFT + 7",    hl.dsp.window.move({ workspace = "7" }))
hl.bind(mainMod .. " + SHIFT + 8",    hl.dsp.window.move({ workspace = "8" }))
hl.bind(mainMod .. " + SHIFT + 9",    hl.dsp.window.move({ workspace = "9" }))
hl.bind(mainMod .. " + SHIFT + 0",    hl.dsp.window.move({ workspace = "10" }))
hl.bind(mainMod .. " + CTRL + ALT + Right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + CTRL + ALT + Left",  hl.dsp.window.move({ workspace = "r-1" }))

-- Move window within workspace
hl.bind(mainMod .. " + SHIFT + CTRL + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + CTRL + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + CTRL + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + CTRL + Down",  hl.dsp.window.move({ direction = "d" }))

-- Scroll workspaces with mouse wheel
hl.bind(mainMod .. " + mouse_down",   hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",     hl.dsp.focus({ workspace = "e-1" }))

-- Mouse window move / resize
hl.bind(mainMod .. " + mouse:272",    hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273",    hl.dsp.window.resize(), { mouse = true })
hl.bind(mainMod .. " + Z",            hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + X",            hl.dsp.window.resize(), { mouse = true })

-- Special workspace (scratchpad)
hl.bind(mainMod .. " + ALT + S",      hl.dsp.window.move({ workspace = "special", follow = false }))
hl.bind(mainMod .. " + S",            hl.dsp.workspace.toggle_special(""))

-- Toggle split (dwindle layout)
hl.bind(mainMod .. " + J",            hl.dsp.layout("togglesplit"))

-- Move to workspace silently (no focus follow)
hl.bind(mainMod .. " + ALT + 1",      hl.dsp.window.move({ workspace = "1",  follow = false }))
hl.bind(mainMod .. " + ALT + 2",      hl.dsp.window.move({ workspace = "2",  follow = false }))
hl.bind(mainMod .. " + ALT + 3",      hl.dsp.window.move({ workspace = "3",  follow = false }))
hl.bind(mainMod .. " + ALT + 4",      hl.dsp.window.move({ workspace = "4",  follow = false }))
hl.bind(mainMod .. " + ALT + 5",      hl.dsp.window.move({ workspace = "5",  follow = false }))
hl.bind(mainMod .. " + ALT + 6",      hl.dsp.window.move({ workspace = "6",  follow = false }))
hl.bind(mainMod .. " + ALT + 7",      hl.dsp.window.move({ workspace = "7",  follow = false }))
hl.bind(mainMod .. " + ALT + 8",      hl.dsp.window.move({ workspace = "8",  follow = false }))
hl.bind(mainMod .. " + ALT + 9",      hl.dsp.window.move({ workspace = "9",  follow = false }))
hl.bind(mainMod .. " + ALT + 0",      hl.dsp.window.move({ workspace = "10", follow = false }))
