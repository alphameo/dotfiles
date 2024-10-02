return {
	"ThePrimeagen/harpoon",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	config = function()
		-- Set a vim motion to <Shift>m to mark a file with harpoon
		vim.keymap.set(
			"n",
			"<leader>hf",
			"<cmd>lua require('harpoon.mark').add_file()<cr>",
			{ desc = "[H]arpoon Mark [F]ile" }
		)
		-- Set a vim motion to the tab key to open the harpoon menu to easily navigate frequented files
		vim.keymap.set(
			"n",
			"<leader>hm",
			"<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
			{ desc = "[H]arpoon Toggle [M]enu" }
		)
	end,
}
