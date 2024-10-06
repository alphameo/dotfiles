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
		vim.keymap.set("n", "<leader>Rc", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run Code" })
		vim.keymap.set("n", "<leader>Rf", ":RunFile<CR>", { noremap = true, silent = false, desc = "Run File" })
		vim.keymap.set("n", "<leader>Rt", ":RunFile tab<CR>", { noremap = true, silent = false, desc = "Run File Tab" })
		vim.keymap.set("n", "<leader>Rp", ":RunProject<CR>", { noremap = true, silent = false, desc = "Run Project" })
		vim.keymap.set("n", "<leader>Rq", ":RunClose<CR>", { noremap = true, silent = false, desc = "Run Quit" })
		-- vim.keymap.set("n", "<leader>crf", ":CRFiletype<CR>", { noremap = true, silent = false })
		-- vim.keymap.set("n", "<leader>crp", ":CRProjects<CR>", { noremap = true, silent = false })
	end,
}
