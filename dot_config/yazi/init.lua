-- INFO: update: $ ya pkg upgrade
-- ya pkg add yazi-rs/plugins:chmod
-- ya pkg add KKV9/compress
-- ya pkg add yazi-rs/plugins:full-border
-- ya pkg add yazi-rs/plugins:git
-- ya pkg add boydaihungst/gvfs
-- ya pkg add yazi-rs/plugins:mount
-- ya pkg add uhs-robert/recycle-bin
-- ya pkg add Ape/reflink
-- ya pkg add boydaihungst/restore
-- ya pkg add Rolv-Apneseth/starship

require("full-border"):setup({
	type = ui.Border.ROUNDED,
})

require("git"):setup()
require("recycle-bin"):setup()

-- Show symlink in status bar
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)

require("starship"):setup({
	-- Hide flags (such as filter, find and search). This is recommended for starship themes which
	-- are intended to go across the entire width of the terminal.
	hide_flags = false, -- Default: false
	-- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
	flags_after_prompt = true, -- Default: true
	-- Custom starship configuration file to use
	config_file = "~/.config/starship.toml", -- Default: nil
})
