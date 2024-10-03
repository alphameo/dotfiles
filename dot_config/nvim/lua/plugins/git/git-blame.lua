return {
	-- Git Blame
	"f-person/git-blame.nvim",
	event = "VeryLazy",
	opts = {
		enabled = true, -- disable by default, enabled only on keymap
		date_format = "%m/%d/%y %H:%M:%S", -- more concise date format
	},

	vim.keymap.set(
		"n",
		"<leader>gb",
		":GitBlameToggle<CR>",
		{ noremap = true, silent = true, desc = "Toggle [G]it [B]lame" }
	), -- toggle git blame
}
