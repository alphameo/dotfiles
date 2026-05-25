-- Hyprland Config guide
-- https://wiki.hypr.land/Configuring/

-------------
--- THEME ---
-------------

local theme = require "hyprland.theme"
local wallpaper_path = "$HOME/Media/Pictures/Wallpapers/astronaut.jpg"

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
  hl.exec_cmd "waybar" -- Statusbar
  -- hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
  -- hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
  hl.exec_cmd "copyq --start-server" -- GUI clipboard history

  hl.exec_cmd "awww-daemon" -- Wallpaper server
  hl.exec_cmd("awww img" .. wallpaper_path) -- Wallpaper
  hl.exec_cmd "systemctl --user start hyprpolkitagent" -- GUI sudo prompt

  -- hl.exec_cmd("dunst") -- Notifications
  hl.exec_cmd "swaync" -- Notifications

  hl.exec_cmd "udiskie" -- Mounter

  hl.exec_cmd "hypridle" -- For lock

  hl.exec_cmd "hyprpm reload" -- Hypr plugin manager (run hyprpm update)

  hl.exec_cmd "[workspace 1 silent] $TERMINAL"
end)

-----------------------------
--- ENVIRONMENT VARIABLES ---
-----------------------------
-- https://wiki.hypr.land/Configuring/Environment-variables/

-- At first, create symlink to cursor theme at /home/a1pha/.local/share/icons (e.g. from /usr/share/icons)
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

hl.env("SWWW_TRANSITION", "any")
hl.env("SWWW_TRANSITION_FPS", "60")
hl.env("DEFAULT_WALLPAPER", wallpaper_path)

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
    gaps_in = 2,
    gaps_out = 4,

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

local win_title_dialog = "^(.*[Ss]ave.*|[Oo]pen.*|[Ff]ile.*|[Cc]hoose.*)$"
hl.window_rule { match = { title = win_title_dialog }, float = true }
hl.window_rule { match = { title = win_title_dialog }, size = { 900, 600 } }
hl.window_rule { match = { title = win_title_dialog }, center = true }

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
hl.window_rule { match = { class = win_class_flameshot }, no_initial_focus = true }
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
-- https://github.com/hyprwm/hyprland-plugins
-- On appearing any issues: `hyprpm update`

if hl.plugin.hyprexpo ~= nil then
  hl.config {
    plugin = {
      hyprexpo = {
        columns = 3,
        gap_size = 1,
        bg_col = "rgb(000000)",
        workspace_method = "first 1",
      },
    },
  }
end
-- https://github.com/VirtCode/hypr-dynamic-cursors
if hl.plugin.dynamic_cursors ~= nil then
  hl.config {
    plugin = {
      dynamic_cursors = {
        enabled = false,
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
          threshold = 6.0,
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
hl.bind(mod .. "T", hl.dsp.exec_cmd "$TERMINAL")
hl.bind(mod .. "B", hl.dsp.exec_cmd "$BROWSER")
hl.bind(mod .. "E", hl.dsp.exec_cmd "$EXPLORER")
hl.bind(mod .. "R", hl.dsp.exec_cmd "~/.scripts/runner")
hl.bind(mod .. "I", hl.dsp.exec_cmd "~/.scripts/settings")

-- Utility
hl.bind(mod .. "CTRL + R", hl.dsp.exec_cmd "~/.scripts/desktop-environment-reload")
hl.bind(mod .. "CTRL + M", hl.dsp.exec_cmd "~/.scripts/task-manager")
hl.bind("CTRL + SHIFT + escape", hl.dsp.exec_cmd "~/.scripts/task-manager")
hl.bind(mod .. "CTRL + B", hl.dsp.exec_cmd "~/.scripts/bluetooth-manager")
hl.bind(mod .. "CTRL + N", hl.dsp.exec_cmd "~/.scripts/network-manager")
hl.bind(mod .. "CTRL + S", hl.dsp.exec_cmd "~/.scripts/sound-sink-manager")
hl.bind(mod .. "CTRL + L", hl.dsp.exec_cmd "~/.scripts/system-lock")
hl.bind(mod .. "CTRL + W", hl.dsp.exec_cmd "~/.scripts/wallpaper-manager")
hl.bind(mod .. "CTRL + SHIFT + W", hl.dsp.exec_cmd "~/.scripts/wallpaper-reset")
hl.bind(mod .. "CTRL + C", hl.dsp.exec_cmd "~/.scripts/colorpicker")
hl.bind(mod .. "CTRL + semicolon", hl.dsp.exec_cmd "~/.scripts/emojipicker")
hl.bind(mod .. "SHIFT + S", hl.dsp.exec_cmd "~/.scripts/screenshot-capture")
hl.bind(mod .. "V", hl.dsp.exec_cmd "~/.scripts/clipboard")
hl.bind(mod .. "SHIFT + P", hl.dsp.exec_cmd "~/.scripts/display-manager")
-- TODO: refactor when available
-- hl.bind(mod .. "TAB", hl.dsp.exec_cmd "hyprcrtl hyprexpo:expo toggle")

hl.bind(mod .. "F", hl.dsp.window.float { action = "toggle" })
hl.bind(mod .. "P", hl.dsp.window.pseudo())
hl.bind(mod .. "return", hl.dsp.window.fullscreen { mode = "maximized", action = "toggle" })
hl.bind(mod .. "f11", hl.dsp.window.fullscreen { mode = "fullscreen", action = "toggle" })

-- -1 (current) | 0 (none) | 1 (maximize) | 2 (fullscreen) | 3 (maximized&fullscreen)
hl.bind(mod .. "CTRL + return", hl.dsp.window.fullscreen_state { internal = 1, client = 0, action = "toggle" })

hl.bind(mod .. "Q", hl.dsp.window.close())
hl.bind(mod .. "SHIFT + Q", hl.dsp.window.kill())

require "hyprland.lo-dwindle"

hl.bind(mod .. "bracketleft", hl.dsp.focus { workspace = "-1" })
hl.bind(mod .. "bracketright", hl.dsp.focus { workspace = "+1" })
hl.bind(mod .. "SHIFT + bracketleft", hl.dsp.window.move { workspace = "-1", follow = true })
hl.bind(mod .. "SHIFT + bracketright", hl.dsp.window.move { workspace = "+1", follow = true })
hl.bind(mod .. "CTRL + SHIFT + bracketleft", hl.dsp.window.move { workspace = "-1", follow = false })
hl.bind(mod .. "CTRL + SHIFT + bracketright", hl.dsp.window.move { workspace = "+1", follow = false })
for key = 1, 8 do
  hl.bind(mod .. key, hl.dsp.focus { workspace = key })
  hl.bind(mod .. "SHIFT + " .. key, hl.dsp.window.move { workspace = key, follow = true })
  hl.bind(mod .. "CTRL + SHIFT + " .. key, hl.dsp.window.move { workspace = key, follow = false })
end

hl.bind(mod .. "apostrophe", hl.dsp.workspace.toggle_special "scratch")
hl.bind(mod .. "SHIFT + apostrophe", hl.dsp.window.move { workspace = "special:scratch", follow = true })
hl.bind(mod .. "CTRL + apostrophe", hl.dsp.window.move { workspace = "special:scratch", follow = false })

hl.bind(mod .. "H", hl.dsp.focus { direction = "left" })
hl.bind(mod .. "J", hl.dsp.focus { direction = "down" })
hl.bind(mod .. "K", hl.dsp.focus { direction = "up" })
hl.bind(mod .. "L", hl.dsp.focus { direction = "right" })
hl.bind(mod .. "left", hl.dsp.window.move { direction = "left" })
hl.bind(mod .. "right", hl.dsp.window.move { direction = "right" })
hl.bind(mod .. "up", hl.dsp.window.move { direction = "up" })
hl.bind(mod .. "down", hl.dsp.window.move { direction = "down" })
hl.bind(mod .. "SHIFT + left", hl.dsp.window.swap { direction = "left" })
hl.bind(mod .. "SHIFT + right", hl.dsp.window.swap { direction = "right" })
hl.bind(mod .. "SHIFT + up", hl.dsp.window.swap { direction = "up" })
hl.bind(mod .. "SHIFT + down", hl.dsp.window.swap { direction = "down" })
hl.bind(mod .. "CTRL + backslash", hl.dsp.exec_cmd "~/.config/hypr/scripts/swap-layout.sh")
-- TODO: refactor when fix
local resize = 5
hl.bind(mod .. "minus", hl.dsp.window.resize { x = 0, y = -resize })
hl.bind(mod .. "period", hl.dsp.window.resize { x = resize, y = 0 })
hl.bind(mod .. "equal", hl.dsp.window.resize { x = 0, y = resize })
hl.bind(mod .. "comma", hl.dsp.window.resize { x = -resize, y = 0 })

---------------------
--- MOUSEMAPPINGS ---
---------------------

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mod .. "mouse_down", hl.dsp.focus { workspace = "e+1" })
hl.bind(mod .. "mouse_up", hl.dsp.focus { workspace = "e-1" })

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mod .. "mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mod .. "mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------
--- FNMAPPINGS ---
------------------
-- Laptop multimedia keys for volume and LCD brightness
hl.bind(
  "XF86AudioRaiseVolume",
  hl.dsp.exec_cmd "wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioLowerVolume",
  hl.dsp.exec_cmd "wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle",
  { locked = true, repeating = true }
)
hl.bind(
  "XF86AudioMicMute",
  hl.dsp.exec_cmd "wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle",
  { locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%+", { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd "brightnessctl -e4 -n2 set 5%-", { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd "playerctl next", { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd "playerctl play-pause", { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd "playerctl previous", { locked = true })
