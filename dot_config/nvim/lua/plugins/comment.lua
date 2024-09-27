return {
	"numToStr/Comment.nvim",
	opts = {
		-- -Add a space b/w comment and the line
		padding = true,
		---Whether the cursor should stay at its position
		-- sticky = true,
		---Lines to be ignored while (un)comment
		ignore = nil,
		toggler = {
			---Line-comment toggle keymap
			line = "<leader>c",
			---Block-comment toggle keymap
			block = "<C-S-/>",
		},
		mappings = {
			basic = true,
		},
	},
}
