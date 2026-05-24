hl.config {
  general = {
    layout = "dwindle",
  },
  -- https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/
  dwindle = {
    force_split = 0,
    preserve_split = true,
    smart_split = false,
    smart_resizing = true,
    permanent_direction_override = false,
    special_scale_factor = 1,
    split_width_multiplier = 1.0,
    use_active_for_splits = true,
    default_split_ratio = 1.0,
    split_bias = 0,
    precise_mouse_move = false,
  },
}

local mod = "SUPER +"
hl.unbind(mod .. "backslash")
hl.unbind(mod .. "SHIFT + backslash")
hl.bind(mod .. "backslash", hl.dsp.layout "togglesplit")
hl.bind(mod .. "SHIFT + backslash", hl.dsp.layout "swapsplit")
