-- Opacity: browsers
hl.window_rule({ match = { class = "^(firefox)$"        }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(Brave-browser)$"  }, opacity = "0.90 0.90" })

-- Opacity: editors
hl.window_rule({ match = { class = "^(code-oss)$"                   }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(Code)$"                       }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(code-url-handler)$"           }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(code-insiders-url-handler)$"  }, opacity = "0.80 0.80" })

-- Opacity: terminal & file manager
hl.window_rule({ match = { class = "^(kitty)$"            }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(org\\.kde\\.dolphin)$" }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(org\\.kde\\.ark)$"     }, opacity = "0.80 0.80" })

-- Opacity: theming utilities
hl.window_rule({ match = { class = "^(nwg-look)$"        }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(qt5ct)$"           }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(qt6ct)$"           }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(kvantummanager)$"  }, opacity = "0.80 0.80" })

-- Opacity: system tray apps
hl.window_rule({ match = { class = "^(org\\.pulseaudio\\.pavucontrol)$"                      }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(blueman-manager)$"                                      }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(nm-applet)$"                                            }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(nm-connection-editor)$"                                 }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(org\\.kde\\.polkit-kde-authentication-agent-1)$"        }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(polkit-gnome-authentication-agent-1)$"                  }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop\\.gtk)$"    }, opacity = "0.80 0.70" })
hl.window_rule({ match = { class = "^(org\\.freedesktop\\.impl\\.portal\\.desktop\\.hyprland)$" }, opacity = "0.80 0.70" })

-- Opacity: media & gaming
hl.window_rule({ match = { class = "^([Ss]team)$"        }, opacity = "0.70 0.70" })
hl.window_rule({ match = { class = "^(steamwebhelper)$"  }, opacity = "0.70 0.70" })
hl.window_rule({ match = { class = "^(Spotify)$"         }, opacity = "0.70 0.70" })
hl.window_rule({ match = { initial_title = "^(Spotify Free)$" }, opacity = "0.70 0.70" })

-- Opacity: electron / flatpak-style apps
hl.window_rule({ match = { class = "^(com\\.github\\.rafostar\\.Clapper)$"           }, opacity = "0.90 0.90" })
hl.window_rule({ match = { class = "^(com\\.github\\.tchx84\\.Flatseal)$"            }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(hu\\.kramo\\.Cartridges)$"                     }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(com\\.obsproject\\.Studio)$"                   }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(gnome-boxes)$"                                  }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(discord)$"                                      }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(WebCord)$"                                      }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(ArmCord)$"                                      }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(app\\.drey\\.Warp)$"                            }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(net\\.davidotek\\.pupgui2)$"                    }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(yad)$"                                          }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(Signal)$"                                       }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(io\\.github\\.alainm23\\.planify)$"             }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(io\\.gitlab\\.theevilskeleton\\.Upscaler)$"     }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(com\\.github\\.unrud\\.VideoDownloader)$"       }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(io\\.gitlab\\.adhami3310\\.Impression)$"        }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(io\\.missioncenter\\.MissionCenter)$"           }, opacity = "0.80 0.80" })
hl.window_rule({ match = { class = "^(io\\.github\\.flattool\\.Warehouse)$"           }, opacity = "0.80 0.80" })

-- Float: dialogs and pop-outs
hl.window_rule({ match = { class = "^(org\\.kde\\.dolphin)$", title = "^(Progress Dialog — Dolphin)$" }, float = true })
hl.window_rule({ match = { class = "^(org\\.kde\\.dolphin)$", title = "^(Copying — Dolphin)$"         }, float = true })
hl.window_rule({ match = { class = "^(firefox)$",             title = "^(Picture-in-Picture)$"         }, float = true })
hl.window_rule({ match = { class = "^(firefox)$",             title = "^(Library)$"                    }, float = true })

-- Float: terminal monitors
hl.window_rule({ match = { class = "^(kitty)$", title = "^(top)$"  }, float = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "^(btop)$" }, float = true })
hl.window_rule({ match = { class = "^(kitty)$", title = "^(htop)$" }, float = true })

-- Float: utilities
hl.window_rule({ match = { class = "^(vlc)$"              }, float = true })
hl.window_rule({ match = { class = "^(kvantummanager)$"   }, float = true })
hl.window_rule({ match = { class = "^(qt5ct)$"            }, float = true })
hl.window_rule({ match = { class = "^(qt6ct)$"            }, float = true })
hl.window_rule({ match = { class = "^(nwg-look)$"         }, float = true })
hl.window_rule({ match = { class = "^(org\\.kde\\.ark)$"  }, float = true })
