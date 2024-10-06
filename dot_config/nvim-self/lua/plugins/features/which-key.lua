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
			{ "<leader>a", group = "[A]ppearance" },
			{ "<leader>c", group = "[C]ode" },
			{ "<leader>cs", group = "[C]ode [S]imbols" },
			{ "<leader>d", group = "[D]ebug" },
			{ "<leader>f", group = "[F]ile" },
			{ "<leader>ff", group = "[F]orce" },
			{ "<leader>g", group = "[G]it" },
			{ "<leader>h", group = "[H]arpoon" },
			{ "<leader>l", group = "[L]anguage" },
			{ "<leader>lt", group = "[T]est" },
			{ "<leader>r", group = "[R]un" },
			{ "<leader>s", group = "[S]earch" },
			{ "<leader>t", group = "[T]ab" },
			{ "<leader>w", group = "[W]indow" },
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
