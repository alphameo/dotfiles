hl.config {
  general = {
    layout = "scrolling",
  },
  -- https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/
  scrolling = {
    column_width = 0.5,
    explicit_column_widths = "0.333, 0.5, 0.667, 1.0",
    fullscreen_on_one_column = false,
    follow_focus = true,
    follow_min_visible = 0.4,
    wrap_focus = false,
    wrap_swapcol = false,
    focus_fit_method = 1, -- 0 - center | 1 - fit
    direction = "right",
  },
}

local mod = "SUPER +"

hl.unbind(mod .. "SHIFT + L")
hl.unbind(mod .. "SHIFT + H")
hl.bind(mod .. "SHIFT + L", hl.dsp.layout "move +col")
hl.bind(mod .. "SHIFT + H", hl.dsp.layout "move -col")

hl.unbind(mod .. "SHIFT + 9")
hl.unbind(mod .. "SHIFT + 0")
hl.bind(mod .. "SHIFT + 9", hl.dsp.layout "swapcol l")
hl.bind(mod .. "SHIFT + 0", hl.dsp.layout "swapcol r")

hl.unbind(mod .. "SHIFT + A")
hl.unbind(mod .. "SHIFT + V")
hl.unbind(mod .. "SHIFT + E")
hl.unbind(mod .. "SHIFT + B")
hl.unbind(mod .. "SHIFT + return")
hl.bind(mod .. "SHIFT + A", hl.dsp.layout "fit active")
hl.bind(mod .. "SHIFT + V", hl.dsp.layout "fit visible")
hl.bind(mod .. "SHIFT + E", hl.dsp.layout "fit toend")
hl.bind(mod .. "SHIFT + B", hl.dsp.layout "fit tobeg")
hl.bind(mod .. "SHIFT + return", hl.dsp.layout "fit all")

hl.unbind(mod .. "SHIFT + minus")
hl.unbind(mod .. "SHIFT + equal")
hl.bind(mod .. "SHIFT + minus", hl.dsp.layout "colresize -conf")
hl.bind(mod .. "SHIFT + equal", hl.dsp.layout "colresize +conf")

hl.unbind(mod .. "N")
hl.bind(mod .. "N", hl.dsp.layout "promote")

hl.unbind(mod .. "backslash")
hl.bind(mod .. "backslash", hl.dsp.layout "togglefit")

-- FIX: fixes maximization behavior (https://github.com/hyprwm/Hyprland/discussions/14380)
hl.unbind(mod .. "return")
local had_left_neighbor = false
hl.bind(mod .. "return", function()
  local w = hl.get_active_window()
  if w == nil then
    return
  end

  local win_w = w.width or w.w or (w.size and w.size.x) or (w.size and w.size[1])
  local mon = w.monitor
  local mon_w = mon and (mon.width or mon.w or (mon.size and mon.size.x))
  if not win_w or not mon_w then
    return
  end

  local ratio = win_w / mon_w

  if ratio < 0.85 then
    -- About to maximize: check if there's a column to the left by trying
    -- to focus left and seeing if the focused window changes.
    local before = w
    hl.dispatch(hl.dsp.layout "focus l")
    local after = hl.get_active_window()
    had_left_neighbor = (after ~= nil and after ~= before)
    -- Restore focus to original column before maximizing.
    if had_left_neighbor then
      hl.dispatch(hl.dsp.layout "focus r")
    end
    hl.dispatch(hl.dsp.layout "colresize 1.0")
  else
    -- Shrinking: only do the nudge if we had a left neighbor going in.
    hl.dispatch(hl.dsp.layout "colresize 0.5")
    if had_left_neighbor then
      hl.dispatch(hl.dsp.layout "focus l")
      hl.dispatch(hl.dsp.layout "focus r")
    end
    had_left_neighbor = false
  end
end, { description = "Toggle active window to maximized (scrolling)" })
