-- Input configuration

hl.config({
    input = {
        -- sensitivity = -0.25,
        accel_profile = "flat",
        kb_layout = "us,ara",
        kb_options = "grp:alt_shift_toggle",
    },
    cursor = {
        -- Adwaita is XCursor-only; with hyprcursor on, Hyprland silently falls back to Bibata
        enable_hyprcursor = false,
        -- no_hardware_cursors = 1, -- uncomment for software cursors; can help with cursor display issues
    },
})

hl.gesture({ fingers = 4, direction = "horizontal", action = "workspace" })
hl.gesture({ fingers = 3, direction = "down",       action = "close" })
hl.gesture({ fingers = 3, direction = "up",         action = "fullscreen" })
hl.gesture({ fingers = 3, direction = "left",       action = "float" })

-- disabling dualsense touchpad when wired
hl.device({
  name    = "sony-interactive-entertainment-dualsense-wireless-controller-touchpad",
  enabled = false,
})

hl.device({
  name    = "dualsense-wireless-controller-touchpad",
  enabled = false,
})
