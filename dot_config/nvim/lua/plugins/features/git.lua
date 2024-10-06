return {
	-- Git Blame
	{
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = true, -- disable by default, enabled only on keymap
			date_format = "%m/%d/%y %H:%M:%S", -- more concise date format
		},

		vim.keymap.set(
			"n",
			"<leader>Gb",
			":GitBlameToggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle [G]it [B]lame" }
		),
	},
	{
		-- Git side status
		"lewis6991/gitsigns.nvim",
		opts = {
			-- See `:help gitsigns.txt`
			signs = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
			signs_staged = {
				add = { text = "+" },
				change = { text = "~" },
				delete = { text = "_" },
				topdelete = { text = "‾" },
				changedelete = { text = "~" },
			},
		},
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
		config = function()
			-- vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
			vim.keymap.set("n", "<leader>GA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
			vim.keymap.set("n", "<leader>Ga", "Git add", { desc = "[G]it [A]dd" })
			vim.keymap.set("n", "<leader>Gc", ":Git commit", { desc = "[G]it [C]ommit" })
			vim.keymap.set("n", "<leader>Gp", "Git push", { desc = "[G]it [P]ush" })
		end,
	},
}
