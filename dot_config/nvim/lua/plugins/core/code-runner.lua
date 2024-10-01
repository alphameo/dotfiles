return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"java -classpath $($HOME/.config/nvim/utility/mvn_cp_cache.sh):target/classes",
					-- "java -classpath $(mvn -o -q dependency:build-classpath -Dmdep.outputFile=/dev/stdout -DincludeScope=runtime):target/classes",
					"$(grep '^package' $dir/$fileName | awk '{print $2}' | sed 's/;//').$fileNameWithoutExt",
				},
			},
		})
		vim.keymap.set("n", "<leader>rc", ":RunCode<CR>", { noremap = true, silent = false, desc = "[R]un [C]ode" })
		vim.keymap.set("n", "<leader>rf", ":RunFile<CR>", { noremap = true, silent = false, desc = "[R]un [F]ile" })
		vim.keymap.set("n", "<leader>rft", ":RunFile tab<CR>", { noremap = true, silent = false, desc = "[R]un [F]ile [T]ab" })
		vim.keymap.set("n", "<leader>rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "[R]un [P]roject" })
		vim.keymap.set("n", "<leader>rq", ":RunClose<CR>", { noremap = true, silent = false, desc = "[R]un [Q]uit" })
		-- vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
		-- vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
	end,
}
