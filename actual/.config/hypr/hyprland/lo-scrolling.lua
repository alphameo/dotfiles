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

local mod = "SUPER + "

hl.unbind(mod .. "SHIFT + l")
hl.unbind(mod .. "SHIFT + h")
hl.bind(mod .. "SHIFT + l", hl.dsp.layout "move +col", { description = "Goto Next Column" })
hl.bind(mod .. "SHIFT + h", hl.dsp.layout "move -col", { description = "Goto Previous Column" })

hl.unbind(mod .. "SHIFT + 9")
hl.unbind(mod .. "SHIFT + 0")
hl.bind(mod .. "SHIFT + 9", hl.dsp.layout "swapcol l", { description = "Swap Next Column" })
hl.bind(mod .. "SHIFT + 0", hl.dsp.layout "swapcol r", { description = "Swap Previous Column" })

hl.unbind(mod .. "SHIFT + w")
hl.unbind(mod .. "w")
hl.bind(mod .. "SHIFT + w", hl.dsp.layout "colresize -conf", { description = "Next Window Width Preset" })
hl.bind(mod .. "w", hl.dsp.layout "colresize +conf", { description = "Previous Window Width Preset" })

hl.unbind(mod .. "n")
hl.bind(mod .. "n", hl.dsp.layout "promote", { description = "Extract Window to New Column" })

hl.unbind(mod .. "CTRL + left")
hl.bind(
  mod .. "CTRL + left",
  hl.dsp.layout "consume_or_expel prev",
  { description = "Exctract/Consume Window from Previous Column" }
)
hl.unbind(mod .. "CTRL + right")
hl.bind(
  mod .. "CTRL + right",
  hl.dsp.layout "consume_or_expel next",
  { description = "Exctract/Consume Window from Next Column" }
)

hl.unbind(mod .. "backslash")
hl.bind(mod .. "backslash", hl.dsp.layout "fit_into_view", { description = "Fit Window into View" })
