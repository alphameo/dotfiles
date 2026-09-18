-- Hyprland Config guide
-- https://wiki.hypr.land/Configuring/

--------------
--- PRESET ---
--------------

require "hyprland.preset-noctalia"

-------------
--- THEME ---
-------------

local theme = require "hyprland.theme"

----------------
--- MONITORS ---
----------------
-- https://wiki.hypr.land/Configuring/Monitors/

hl.monitor {
  output = "eDP-1",
  mode = "1920x1080@60",
  position = "0x0",
  scale = "1",
}
hl.monitor {
  output = "HDMI-A-1",
  mode = "1024x768@60.00400",
  position = "1920x0",
  scale = "1",
}

-- nwg-displays
require "monitors"

hl.workspace_rule { workspace = "1", monitor = "eDP-1", default = true, persistent = true }
hl.workspace_rule { workspace = "4", monitor = "HDMI-A-1", default = true, persistent = false }
hl.workspace_rule { workspace = "special:magic", monitor = "HDMI-A-1", default = true, persistent = false }

-----------------
--- AUTOSTART ---
-----------------
-- https://wiki.hypr.land/Configuring/Basics/Autostart/

hl.on("hyprland.start", function()
  hl.exec_cmd "systemctl --user start hyprpolkitagent" -- GUI sudo prompt

  hl.exec_cmd "udiskie" -- Mounter

  hl.exec_cmd "hyprpm reload" -- Hypr plugin manager (run hyprpm update)

  hl.exec_cmd "[workspace 1 silent] $TERMINAL"
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
-- https://wiki.hypr.land/Configuring/Environment-variables/

-- At first, create symlink to cursor theme at ~/.local/share/icons (e.g. from /usr/share/icons)
-- sudo ln -rs ~/.local/share/icons/Bibata-Modern-Classic/ /usr/share/icons/Bibata-Modern-Classic
hl.env("HYPRCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "24")

hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")

-------------------
--- PERMISSIONS ---
-------------------
-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/

hl.config {
  ecosystem = {
    no_update_news = false,
    no_donation_nag = true,
    enforce_permissions = false,
  },
}

-------------------
--- LOOK & FEEL ---
-------------------

hl.config {
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#general
  general = {
    gaps_in = 1,
    gaps_out = 2,

    border_size = 1,

    col = {
      active_border = theme.color_border,
      inactive_border = theme.color_border_inactive,
    },

    resize_on_border = true,
    resize_corner = 3,
    extend_border_grab_area = 3,
    hover_icon_on_border = true,

    allow_tearing = false,

    layout = "dwindle",
  },
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#group
  group = {
    auto_group = true,
    insert_after_current = true,
    focus_removed_window = true,

    merge_groups_on_drag = true,

    col = {
      border_active = theme.color_border,
      border_inactive = theme.color_border_inactive,
    },
    groupbar = {
      enabled = true,

      font_size = 12,

      gradients = true,
      height = 20,
      stacked = false,
      render_titles = true,

      scrolling = true,

      text_color = theme.color_fg,
      col = {
        active = theme.color_bg,
        inactive = theme.color_bg_inactive,
      },
    },
  },
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#decoration
  decoration = {
    rounding = 8,
    rounding_power = 2,

    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0,

    dim_inactive = false,
    dim_strength = 0.2,

    shadow = {
      enabled = true,
      range = 4,

      -- ignore_window = true,
      sharp = false,

      render_power = 2,
      color = "rgba(1a1a1aee)",

      offset = { 0.0, 0.0 },
      scale = 1.0,
    },

    -- https://wiki.hypr.land/Configuring/Basics/Variables/#blur
    blur = {
      enabled = true,

      size = 10,
      passes = 3,

      xray = false,

      ignore_opacity = true,

      new_optimizations = true,

      noise = 0,
      contrast = 0.9,
      brightness = 0.8,
      vibrancy = 0.2,
      vibrancy_darkness = 0.5,

      special = false,
      popups = true,
      popups_ignorealpha = 0.2,
    },
  },
  -- https://wiki.hypr.land/Configuring/Basics/Variables/#animations
  animations = {
    enabled = true,
  },
}

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/#curves
-- hl.curve( NAME, { type = "bezier", points = { {X0, Y0}, {X1, Y1} } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations
-- hl.animation({ leaf = STRING, enabled = BOOLEAN, speed = FLOAT, curve = STRING[, style = STRING] })
hl.animation { leaf = "global", enabled = true, speed = 10, bezier = "default" }
hl.animation { leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" }
hl.animation { leaf = "windows", enabled = true, speed = 4.79, bezier = "easeOutQuint" }
hl.animation { leaf = "windowsIn", enabled = true, speed = 4.1, bezier = "easeOutQuint", style = "popin 87%" }
hl.animation { leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" }
hl.animation { leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" }
hl.animation { leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" }
hl.animation { leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" }
hl.animation { leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" }
hl.animation { leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" }
hl.animation { leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" }
hl.animation { leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" }
hl.animation { leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" }
hl.animation { leaf = "workspaces", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" }
hl.animation { leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" }
hl.animation { leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" }
hl.animation { leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" }

-- https://wiki.hypr.land/Configuring/Basics/Variables/#misc
hl.config {
  misc = {
    force_default_wallpaper = 0,
    disable_hyprland_logo = true,
    disable_splash_rendering = true,

    font_family = "RobotoMono Nerd Font",

    vrr = 0,
    disable_autoreload = true,
  },
}

-- https://wiki.hypr.land/Configuring/Basics/Variables/#debug
hl.config {
  debug = {
    vfr = true,
  },
}

----------------------------
--- WINDOW & LAYER RILES ---
----------------------------
-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- For recognizing window classes inspect: hyprctl clients
-- For recognizing layer namespaces inspect: hyprctl layers

hl.window_rule { match = { class = ".*" }, suppress_event = "maximize" }
hl.window_rule { match = { tag = "alpha-0.9" }, opacity = 0.9 }

local suppressMaximizeRule = hl.window_rule {
  -- Ignore maximize requests from all apps. You'll probably like this.
  name = "suppress-maximize-events",
  match = { class = ".*" },

  suppress_event = "maximize",
}
suppressMaximizeRule:set_enabled(false)

-- Fix dragging issues with XWayland
hl.window_rule {
  name = "fix-xwayland-drags",
  match = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
  no_focus = true,
}

local win_class_all = "^(.*)$"
hl.window_rule { match = { class = win_class_all }, idle_inhibit = "fullscreen" }
hl.window_rule { match = { title = win_class_all }, idle_inhibit = "fullscreen" }
hl.window_rule { match = { fullscreen = true }, idle_inhibit = "fullscreen" }

local win_class_rofi = "^(rofi)$"
hl.window_rule { match = { class = win_class_rofi }, float = true }
hl.window_rule { match = { class = win_class_rofi }, center = true }
hl.window_rule { match = { class = win_class_rofi }, pin = true }

local win_class_copyq = "^(com.github.hluk.copyq)$"
hl.window_rule { match = { class = win_class_copyq }, float = true }
hl.window_rule { match = { class = win_class_copyq }, center = true }
hl.window_rule { match = { class = win_class_copyq }, animation = "fade" }
hl.window_rule { match = { class = win_class_copyq }, border_size = 0 }
hl.window_rule { match = { class = win_class_copyq }, size = { 400, 600 } }

local win_class_waypaper = "^(waypaper)$"
hl.window_rule { match = { class = win_class_waypaper }, float = true }
hl.window_rule { match = { class = win_class_waypaper }, center = true }
hl.window_rule { match = { class = win_class_waypaper }, animation = "fade" }
hl.window_rule { match = { class = win_class_waypaper }, border_size = 0 }
hl.window_rule { match = { class = win_class_waypaper }, size = { 400, 600 } }

local win_class_flameshot = "^(flameshot)$"
hl.window_rule { match = { class = win_class_flameshot }, float = true }
hl.window_rule { match = { class = win_class_flameshot }, no_anim = true }
hl.window_rule { match = { class = win_class_flameshot }, move = { 0, 0 } }
hl.window_rule { match = { class = win_class_flameshot }, pin = true }
hl.window_rule { match = { class = win_class_flameshot }, size = { 1920, 1800 } }
-- set this to your leftmost monitor id,
-- otherwise you have to move your cursor to the leftmost monitor before executing flameshot
hl.window_rule { match = { class = win_class_flameshot }, monitor = 1 }

local win_class_dragon = "^(dragon-drop)$"
hl.window_rule { match = { class = win_class_dragon }, float = true }
hl.window_rule { match = { class = win_class_dragon }, center = true }
hl.window_rule { match = { class = win_class_dragon }, pin = true }

local layer_ns_logout = "^(logout_dialog)$"
hl.layer_rule { match = { namespace = layer_ns_logout }, blur = true }

local win_title_dialog = "^(.*\\b([Ss]ave|[Oo]pen|[Ff]ile|[Cc]hoose)\\b.*)$"
hl.window_rule { match = { title = win_title_dialog }, float = true }
hl.window_rule { match = { title = win_title_dialog }, size = { 900, 600 } }
hl.window_rule { match = { title = win_title_dialog }, center = true }

-------------
--- INPUT ---
-------------
-- https://wiki.hypr.land/Configuring/Basics/Variables/#input
hl.config {
  input = {
    kb_layout = "us,ru",
    kb_variant = "",
    kb_model = "",
    -- options list: $ grep "grp:.*toggle" /usr/share/X11/xkb/rules/base.lst
    kb_options = "grp:caps_toggle, grp:alt_shift_toggle",
    kb_rules = "",

    follow_mouse = 1,

    sensitivity = 0, -- [-1.0 - 1.0]

    touchpad = {
      natural_scroll = true,
    },
  },
}

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/
hl.device {
  name = "epic-mouse-v1",
  sensitivity = -0.5,
}

-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/
hl.gesture {
  fingers = 3,
  direction = "down",
  mods = "ALT",
  action = "close",
}
hl.gesture {
  fingers = 3,
  direction = "up",
  mods = "SUPER",
  scale = 1.5,
  action = "fullscreen",
}
hl.gesture {
  fingers = 3,
  direction = "left",
  scale = 1.5,
  action = "float",
}

---------------
--- PLUGINS ---
---------------
-- hyprpm add
-- https://hypr.land/plugins/
-- On appearing any issues: `hyprpm update`

-- https://github.com/VirtCode/hypr-dynamic-cursors
if hl.plugin.dynamic_cursors ~= nil then
  hl.config {
    plugin = {
      dynamic_cursors = {
        enabled = true,
        mode = "none", -- tilt | rotate | stretch | none
        threshold = 2, -- min angle in deg
        rotate = {
          length = 20, -- of simulated stick for rotation in px
          offset = 0.0, -- clockwise
        },
        tilt = {
          limit = 5000, -- speed in px/s, on which the full_tilt (60° in both directions) is reached
          activation = "negative_quadratic", -- relationship between speed and tilt
          -- linear | quadratic | negative_quadratic
          window = 100, -- time window in ms, over which the speed is calculated
        },
        stretch = {
          limit = 3000, -- speed in px/s, on which the full_stretch (2*orig_length) is reached
          activation = "quadratic", -- relationship between speed and stretch
          -- linear | quadratic | negative_quadratic
          window = 100, -- time window in ms, over which the speed is calculated
        },
        shake = {
          enabled = true,
          threshold = 3.0,
          base = 4.0, -- magnification level on start
          speed = 4.0, -- magnification level on shaking
          influence = 0.0, -- of speed
          limit = 0.0, -- max magnification ([0.0; 1.0] - disable)
          timeout = 2000, -- in ms stay after
          effects = false, -- show cursor behaviour while shaking
          ipc = false, -- ipc events
        },
        hyprcursor = {
          enabled = true,
          nearest = true, -- nearest-neghbour pixelated scaling
          -- 0 - never | 1 - when no highres | 2 - always
          resolution = -1, -- resolution load the magnified shapes at
          -- (px) | -1 - [normal cursor size] * [shake:base option]
          fallback = "clientside",
        },
      },
    },
  }
else
  hl.notification.create { text = "Dynamic-Cursors are unavailable", timeout = 5000 }
end

-------------------
--- KEYMAPPINGS ---
-------------------
-- https://wiki.hypr.land/Configuring/Basics/Variables/#binds

hl.config {
  binds = {
    scroll_event_delay = 0,
    workspace_back_and_forth = true,
  },
}

-- https://wiki.hypr.land/Configuring/Basics/Binds/
local mod = "SUPER + "

-- Applications
hl.bind(mod .. "t", hl.dsp.exec_cmd "$TERMINAL", { description = "Open Terminal" })
hl.bind(mod .. "b", hl.dsp.exec_cmd "$BROWSER", { description = "Open Browser" })
hl.bind(mod .. "e", hl.dsp.exec_cmd "~/.scripts/explorer", { description = "Open File Explorer" })
hl.bind(mod .. "r", hl.dsp.exec_cmd "~/.scripts/launcher", { description = "Open Launcher" })
hl.bind(mod .. "i", hl.dsp.exec_cmd "~/.scripts/settings", { description = "Open Settings" })

-- Utility
hl.bind(
  mod .. "CTRL + r",
  hl.dsp.exec_cmd "~/.scripts/desktop-environment-reload",
  { description = "Reload Environment" }
)
hl.bind(mod .. "CTRL + m", hl.dsp.exec_cmd "~/.scripts/task-manager", { description = "Open Task Manager" })
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd "~/.scripts/task-manager", { description = "Open Task Manager" })
hl.bind(mod .. "CTRL + b", hl.dsp.exec_cmd "~/.scripts/bluetooth-manager", { description = "Open Bluetooth Manager" })
hl.bind(mod .. "CTRL + n", hl.dsp.exec_cmd "~/.scripts/network-manager", { description = "Open Network Manager" })
hl.bind(mod .. "CTRL + s", hl.dsp.exec_cmd "~/.scripts/sound-sink-manager", { description = "Open Sound Manager" })
hl.bind(mod .. "CTRL + l", hl.dsp.exec_cmd "~/.scripts/system-lock", { description = "Lock" })
hl.bind(mod .. "CTRL + w", hl.dsp.exec_cmd "~/.scripts/wallpaper-manager", { description = "Open Wallpapers Manager" })
hl.bind(mod .. "CTRL + c", hl.dsp.exec_cmd "~/.scripts/colorpicker", { description = "Open Color Picker" })
hl.bind(mod .. "CTRL + semicolon", hl.dsp.exec_cmd "~/.scripts/emojipicker", { description = "Open Emoji Picker" })
hl.bind(mod .. "SHIFT + s", hl.dsp.exec_cmd "~/.scripts/screenshot-region", { description = "Screenshot of Region" })
hl.bind(
  mod .. "CTRL + SHIFT + s",
  hl.dsp.exec_cmd "~/.scripts/screenshot-window",
  { description = "Screenshot of Focused Window" }
)
hl.bind(
  mod .. "ALT + s",
  hl.dsp.exec_cmd "~/.scripts/screenshot-fullscreen",
  { description = "Screenshot of Fullscreen" }
)
hl.bind(mod .. "v", hl.dsp.exec_cmd "~/.scripts/clipboard", { description = "Open Clipboard Manager" })
hl.bind(mod .. "SHIFT + p", hl.dsp.exec_cmd "~/.scripts/display-manager", { description = "Open Display Manager" })

hl.bind(mod .. "f1", hl.dsp.exec_cmd "~/.scripts/key-cheatsheet", { description = "Open Keybind Cheatsheet" })

hl.bind(mod .. "f", hl.dsp.window.float { action = "toggle" }, { description = "Toggle Float" })
hl.bind(mod .. "p", hl.dsp.window.pseudo(), { description = "Toggle Pseudo" })
hl.bind(
  mod .. "return",
  hl.dsp.window.fullscreen { mode = "maximized", action = "toggle" },
  { description = "Toggle Fullscreen Window" }
)
hl.bind(
  mod .. "f11",
  hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" },
  { description = "Toggle Fullscreen Window" }
)

-- -1 (current) | 0 (none) | 1 (maximize) | 2 (fullscreen) | 3 (maximized&fullscreen)
hl.bind(
  mod .. "CTRL + return",
  hl.dsp.window.fullscreen_state { internal = 1, client = 0, action = "toggle" },
  { description = "Toggle Maximized Window" }
)

hl.bind(mod .. "q", hl.dsp.window.close(), { description = "Close Window" })
hl.bind(mod .. "SHIFT + q", hl.dsp.window.kill(), { description = "Kill Window" })

require "hyprland.layout-scrolling"

hl.bind(mod .. "bracketleft", hl.dsp.focus { workspace = "-1" }, { description = "Goto Previous Workspace" })
hl.bind(mod .. "bracketright", hl.dsp.focus { workspace = "+1" }, { description = "Goto Next Workspace" })
hl.bind(
  mod .. "SHIFT + bracketleft",
  hl.dsp.window.move { workspace = "-1", follow = true },
  { description = "Move Window to Previous Workspace" }
)
hl.bind(
  mod .. "SHIFT + bracketright",
  hl.dsp.window.move { workspace = "+1", follow = true },
  { description = "Move Window to Next Workspace" }
)
hl.bind(
  mod .. "CTRL + bracketleft",
  hl.dsp.window.move { workspace = "-1", follow = false },
  { description = "Move Window to Previous Workspace Silent" }
)
hl.bind(
  mod .. "CTRL + bracketright",
  hl.dsp.window.move { workspace = "+1", follow = false },
  { description = "Move Window to Next Workspace Silent" }
)
for key = 1, 8 do
  hl.bind(mod .. key, hl.dsp.focus { workspace = key }, { description = "Goto " .. key .. " Workspace" })
  hl.bind(
    mod .. "SHIFT + " .. key,
    hl.dsp.window.move { workspace = key, follow = true },
    { description = "Move Window to " .. key .. " Workspace" }
  )
  hl.bind(
    mod .. "CTRL + " .. key,
    hl.dsp.window.move { workspace = key, follow = false },
    { description = "Move Window to " .. key .. " Workspace Silent" }
  )
end

hl.bind(mod .. "apostrophe", hl.dsp.workspace.toggle_special "scratch", { description = "Goto 'Scratch' Workspace" })
hl.bind(
  mod .. "SHIFT + apostrophe",
  hl.dsp.window.move { workspace = "special:scratch", follow = true },
  { description = "Move Window to 'Scratch' Workspace" }
)
hl.bind(
  mod .. "CTRL + apostrophe",
  hl.dsp.window.move { workspace = "special:scratch", follow = false },
  { description = "Move Window to 'Scratch' Workspace Silent" }
)

hl.bind(mod .. "h", hl.dsp.focus { direction = "left" }, { description = "Focus Window Left" })
hl.bind(mod .. "j", hl.dsp.focus { direction = "down" }, { description = "Focus Window Down" })
hl.bind(mod .. "k", hl.dsp.focus { direction = "up" }, { description = "Focus Window Up" })
hl.bind(mod .. "l", hl.dsp.focus { direction = "right" }, { description = "Focus Window Right" })
hl.bind(mod .. "left", hl.dsp.window.move { direction = "left" }, { description = "Move Window Left" })
hl.bind(mod .. "right", hl.dsp.window.move { direction = "right" }, { description = "Move Window Right" })
hl.bind(mod .. "up", hl.dsp.window.move { direction = "up" }, { description = "Move Window Up" })
hl.bind(mod .. "down", hl.dsp.window.move { direction = "down" }, { description = "Move Window Up" })
hl.bind(mod .. "SHIFT + left", hl.dsp.window.swap { direction = "left" }, { description = "Swap Window Left" })
hl.bind(mod .. "SHIFT + right", hl.dsp.window.swap { direction = "right" }, { description = "Swap Window Right" })
hl.bind(mod .. "SHIFT + up", hl.dsp.window.swap { direction = "up" }, { description = "Swap Window Up" })
hl.bind(mod .. "SHIFT + down", hl.dsp.window.swap { direction = "down" }, { description = "Swap Window Down" })
local resize = 25
hl.bind(
  mod .. "minus",
  hl.dsp.window.resize { x = 0, y = -resize, relative = true },
  { description = "Decrease Window Height" }
)
hl.bind(
  mod .. "equal",
  hl.dsp.window.resize { x = 0, y = resize, relative = true },
  { description = "Increase Window Height" }
)
hl.bind(
  mod .. "period",
  hl.dsp.window.resize { x = resize, y = 0, relative = true },
  { description = "Increase Window Width" }
)
hl.bind(
  mod .. "comma",
  hl.dsp.window.resize { x = -resize, y = 0, relative = true },
  { description = "Decrease Window Width" }
)

---------------------
--- MOUSEMAPPINGS ---
---------------------

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. "mouse_down", hl.dsp.focus { workspace = "e+1" }, { description = "Goto Next Workspace via Mouse" })
hl.bind(mod .. "mouse_up", hl.dsp.focus { workspace = "e-1" }, { description = "Goto Previous Workspace via Mouse" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true, description = "Drag Window with Mouse" })
hl.bind(
  mod .. "mouse:273",
  hl.dsp.window.resize(),
  { mouse = true, description = "Interactive Window Resize via Mouse" }
)

------------------
--- FNMAPPINGS ---
------------------
-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
  { locked = true, repeating = true, description = "Increase Out-Sound" }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
  { locked = true, repeating = true, description = "Decrease Out-Sound" }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
  { locked = true, repeating = true, description = "Toggle Out-Sound Mute" }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
  { locked = true, repeating = true, description = "Toggle In-Sound Mute" }
)
hl.bind(
  "XF86MonBrightnessUp",
  hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%+",
  { locked = true, repeating = true, description = "Increase Brightness" }
)
hl.bind(
  "XF86MonBrightnessDown",
  hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%-",
  { locked = true, repeating = true, description = "Decrease Brightness" }
)

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next", { locked = true, description = "Player Next Composition" })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd "playerctl pause", { locked = true, description = "Player Pause" })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd "playerctl play", { locked = true, description = "Player Play" })
hl.bind(
  "XF86AudioPrev",
  hl.dsp.exec_cmd "playerctl previous",
  { locked = true, description = "Player Next Composition" }
)
