return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("refactoring").setup()

		vim.keymap.set("x", "<leader>re", ":Refactor extract ", { desc = "Refactor: Extract" })
		vim.keymap.set("x", "<leader>rE", ":Refactor extract_to_file ", { desc = "Refactor: Extract to File" })

		vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ", { desc = "Refactor: Extract Variable" })

		vim.keymap.set({ "n", "x" }, "<leader>ri", ":Refactor inline_var<CR>", { desc = "Refactor: Inline Variable" })

		vim.keymap.set("n", "<leader>rI", ":Refactor inline_func<CR>", { desc = "Refactor: Inline Function" })

		vim.keymap.set("n", "<leader>rb", ":Refactor extract_block<CR>", { desc = "Refactor: Extract Block" })
		vim.keymap.set(
			"n",
			"<leader>rB",
			":Refactor extract_block_to_file<CR>",
			{ desc = "Refactor: Extract Block to File" }
		)

		require("telescope").load_extension("refactoring")

		vim.keymap.set({ "n", "x" }, "<leader>rr", function()
			require("telescope").extensions.refactoring.refactors()
		end, { desc = "Refactor: Refactoring Menu" })

		vim.keymap.set("n", "<leader>dp", function()
			require("refactoring").debug.printf({ below = false }, { desc = "Debug: Printf Marker" })
		end)

		vim.keymap.set({ "x", "n" }, "<leader>dP", function()
			require("refactoring").debug.print_var()
		end, { desc = "Debug: Printf Variable" })

		vim.keymap.set("n", "<leader>dpc", function()
			require("refactoring").debug.cleanup({})
		end, { desc = "Debug: Printf Claer" })

		require("refactoring").setup({
			prompt_func_return_type = {
				go = true,
				cpp = true,
				c = true,
				java = true,
			},
			prompt_func_param_type = {
				go = true,
				cpp = true,
				c = true,
				java = true,
			},
		})
	end,
}
