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
			{ "<leader>a", group = "Appearance" },
			{ "<leader>c", group = "Code" },
			{ "<leader>cs", group = "Code Simbols" },
			{ "<leader>d", group = "Debug" },
			{ "<leader>f", group = "File" },
			{ "<leader>g", group = "Goto" },
			{ "<leader>G", group = "Git" },
			{ "<leader>m", group = "Harpoon Marks" },
			{ "<leader>l", group = "Language" },
			{ "<leader>lt", group = "Language Test" },
			{ "<leader>r", group = "Run" },
			{ "<leader>f", group = "Telescope Find" },
			{ "<leader>t", group = "Tab" },
			{ "<leader>w", group = "Window" },
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
