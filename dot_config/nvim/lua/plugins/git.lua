return {
	{
		-- Git Blame
		"f-person/git-blame.nvim",
		event = "VeryLazy",
		opts = {
			enabled = false, -- disable by default, enabled only on keymap
			date_format = "%m/%d/%y %H:%M:%S", -- more concise date format
		},

		vim.keymap.set(
			"n",
			"<leader>gb",
			":GitBlameToggle<CR>",
			{ noremap = true, silent = true, desc = "Toggle [G]it [B]lame" }
		), -- toggle git blame
	},
	{
		-- Powerful Git integration for Vim
		"tpope/vim-fugitive",
		config = function()
			-- Set a vim motion to <Space> + g + b to view the most recent contributers to the file
			-- vim.keymap.set("n", "<leader>gb", ":Git blame<cr>", { desc = "[G]it [B]lame" })
			-- Set a vim motion to <Space> + g + <Shift>A to all files changed to the staging area
			vim.keymap.set("n", "<leader>gA", ":Git add .<cr>", { desc = "[G]it Add [A]ll" })
			-- Set a vim motion to <Space> + g + a to add the current file and changes to the staging area
			vim.keymap.set("n", "<leader>ga", "Git add", { desc = "[G]it [A]dd" })
			-- Set a vim motion to <Space> + g + c to commit the current chages
			vim.keymap.set("n", "<leader>gc", ":Git commit", { desc = "[G]it [C]ommit" })
			-- Set a vim motion to <Space> + g + p to push the commited changes to the remote repository
			vim.keymap.set("n", "<leader>gp", "Git push", { desc = "[G]it [P]ush" })
		end,
	},
	{
		-- GitHub integration for vim-fugitive
		"tpope/vim-rhubarb",
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
}
