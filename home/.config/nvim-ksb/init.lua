require("options")
require("keymaps")

vim.pack.add({
	"https://github.com/mikesmithgh/kitty-scrollback.nvim",
})

vim.keymap.set({ "n", "v" }, "y", [["+y<cmd>q!<cr>]], { desc = "[P]Yank to system clipboard + Quit" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "[P]Yank to system clipboard" })

require("kitty-scrollback").setup({
	{
		status_window = {
			autoclose = false,
			style_simple = false,
		},
		paste_window = {
			highlight_as_normal_win = true,
		},
	},
	ksb_builtin_get_text_all = {
		kitty_get_text = {
			ansi = true,
		},
	},
})
