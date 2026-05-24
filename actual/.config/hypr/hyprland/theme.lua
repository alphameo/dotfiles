local cat = require "hyprland.catppuccin-mocha"

return {
  color_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
  color_border_inactive = "rgba(" .. cat.overlay2Alpha .. "80)",

  color_fg = cat.text,
  color_fg_inactive = cat.text,

  color_bg = cat.base,
  color_bg_inactive = cat.crust,

  color_cardbg = cat.surface0,
  color_cardbg_inactive = cat.surface0,

  color_accent = cat.lavender,

  color_good = cat.green,
  color_ok = cat.blue,
  color_neutral = cat.yellow,
  color_bad = cat.red,
}
