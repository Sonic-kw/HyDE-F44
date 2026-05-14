-- See https://wiki.hyprland.org/Nvidia/
hl.env("LIBVA_DRIVER_NAME",          "nvidia")
hl.env("__GLX_VENDOR_LIBRARY_NAME",  "nvidia")
hl.env("__GL_VRR_ALLOWED",           "1")
hl.env("WLR_NO_HARDWARE_CURSORS",    "1")
hl.env("WLR_DRM_NO_ATOMIC",          "1")
