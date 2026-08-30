-- INFO: update: $ ya pkg upgrade

require("full-border"):setup {
  type = ui.Border.ROUNDED,
}

require("git"):setup {
  -- Order of status signs showing in the linemode
  order = 1500,
}

require("recycle-bin"):setup()

require("starship"):setup {
  -- Hide flags (such as filter, find and search). This is recommended for starship themes which
  -- are intended to go across the entire width of the terminal.
  hide_flags = false, -- Default: false
  -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
  flags_after_prompt = true, -- Default: true
  -- Custom starship configuration file to use
  config_file = os.getenv "STARSHIP_CONFIG" or "~/.config/starship.toml", -- Default: nil
}

require("bookmarks"):setup {
  last_directory = { enable = true, persist = true, mode = "dir" },
  persist = "all",
  desc_format = "full",
  file_pick_mode = "hover",
  custom_desc_input = false,
  show_keys = true,
  notify = {
    enable = true,
    timeout = 1,
    message = {
      new = "New bookmark '<key>' -> '<folder>'",
      delete = "Deleted bookmark in '<key>'",
      delete_all = "Deleted all bookmarks",
    },
  },
}

-- Show symlink in status bar
Status:children_add(function(self)
  local h = self._current.hovered
  if h and h.link_to then
    return " -> " .. tostring(h.link_to)
  else
    return ""
  end
end, 3300, Status.LEFT)

-- Show user/group of files in status bar
Status:children_add(function()
  local h = cx.active.current.hovered
  if not h or ya.target_family() ~= "unix" then
    return ""
  end

  return ui.Line {
    ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg "magenta",
    ":",
    ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg "magenta",
    " ",
  }
end, 500, Status.RIGHT)
