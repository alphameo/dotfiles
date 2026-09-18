local wallpaper_path = "$HOME/Media/Pictures/Wallpapers/astronaut.jpg"

hl.on("hyprland.start", function()
  hl.exec_cmd "waybar" -- Statusbar

  -- hl.exec_cmd("wl-paste --type text --watch cliphist store") -- Stores only text data
  -- hl.exec_cmd("wl-paste --type image --watch cliphist store") -- Stores only image data
  hl.exec_cmd "copyq --start-server" -- GUI clipboard history

  hl.exec_cmd "awww-daemon" -- Wallpaper server

  hl.exec_cmd("awww img" .. wallpaper_path) -- Wallpaper

  -- hl.exec_cmd("dunst") -- Notifications
  hl.exec_cmd "swaync" -- Notifications
end)

hl.env("AWWW_TRANSITION", "any")
hl.env("AWWW_TRANSITION_FPS", "60")
hl.env("DEFAULT_WALLPAPER", wallpaper_path)
