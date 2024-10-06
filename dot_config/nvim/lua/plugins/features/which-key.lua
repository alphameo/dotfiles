return {
	-- Hints keybinds
	"folke/which-key.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "echasnovski/mini.icons", version = false },
	},
	config = function()
		-- gain access to the which key plugin
		local which_key = require("which-key")

		-- call the setup function with default properties
		which_key.setup()

		-- Register prefixes for the different key mappings we have setup previously
		which_key.add({
			{ "<leader>a", group = "Appearance", mode = { "n", "v" } },
			{ "<leader>c", group = "Code", mode = { "n", "v" } },
			{ "<leader>cs", group = "Code Simbols", mode = { "n", "v" } },
			{ "<leader>d", group = "Debug", mode = { "n", "v" } },
			{ "<leader>f", group = "File", mode = { "n", "v" } },
			{ "<leader>g", group = "Goto", mode = { "n", "v" } },
			{ "<leader>G", group = "Git", mode = { "n", "v" } },
			{ "<leader>m", group = "Harpoon Marks", mode = { "n", "v" } },
			{ "<leader>l", group = "Language", mode = { "n", "v" } },
			{ "<leader>R", group = "Run", mode = { "n", "v" } },
			{ "<leader>r", group = "Refactor", mode = { "n", "v" } },
			{ "<leader>f", group = "Telescope Find", mode = { "n", "v" } },
			{ "<leader>t", group = "Tab", mode = { "n", "v" } },
			{ "<leader>w", group = "Window", mode = { "n", "v" } },
		})
	end,

	keys = {
		{
			"<leader>?",
			function()
				require("which-key").show({ global = false })
			end,
			desc = "Buffer Local Keymaps (which-key)",
		},
	},
}
