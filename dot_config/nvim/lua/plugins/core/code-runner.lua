return {
	"CRAG666/code_runner.nvim",
	config = function()
		require("code_runner").setup({
			filetype = {
				java = {
					"java -classpath $(mvn -o -q dependency:build-classpath -Dmdep.outputFile=/dev/stdout -DincludeScope=runtime):target/classes",
					"$(grep '^package' $dir/$fileName | awk '{print $2}' | sed 's/;//').$fileNameWithoutExt",
				},
			},
		})
		vim.keymap.set("n", "<F5>", ":RunCode<CR>", { noremap = true, silent = false, desc = "Run Code" })
	end,
}
