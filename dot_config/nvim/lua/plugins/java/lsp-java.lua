-- Java LSP
return {
	-- https://github.com/mfussenegger/nvim-jdtls
	"mfussenegger/nvim-jdtls",
	dependencies = {
		"mfussenegger/nvim-dap",
		"rcarriga/nvim-dap-ui",
	},
	ft = "java", -- Enable only on .java file extensions

	config = function()
		vim.cmd(
			"command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)"
		)
		-- Allow yourself/register to run JdtUpdateConfig as a Vim command
		vim.cmd("command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()")
		-- Allow yourself/register to run JdtBytecode as a Vim command
		vim.cmd("command! -buffer JdtBytecode lua require('jdtls').javap()")
		-- Allow yourself/register to run JdtShell as a Vim command
		vim.cmd("command! -buffer JdtJshell lua require('jdtls').jshell()")

		vim.keymap.set(
			"n",
			"<leader>jo",
			"<Cmd> lua require('jdtls').organize_imports()<CR>",
			{ desc = "[J]ava [O]rganize Imports" }
		)
		vim.keymap.set(
			"n",
			"<leader>jv",
			"<Cmd> lua require('jdtls').extract_variable()<CR>",
			{ desc = "[J]ava Extract [V]ariable" }
		)
		vim.keymap.set(
			"v",
			"<leader>jv",
			"<Esc><Cmd> lua require('jdtls').extract_variable(true)<CR>",
			{ desc = "[J]ava Extract [V]ariable" }
		)
		vim.keymap.set(
			"n",
			"<leader>jc",
			"<Cmd> lua require('jdtls').extract_constant()<CR>",
			{ desc = "[J]ava Extract [C]onstant" }
		)
		-- Set a Vim motion to <Space> + <Shift>J + <Shift>C to extract the code selected in visual mode to a static variable
		vim.keymap.set(
			"v",
			"<leader>jc",
			"<Esc><Cmd> lua require('jdtls').extract_constant(true)<CR>",
			{ desc = "[J]ava Extract [C]onstant" }
		)
		-- Set a Vim motion to <Space> + <Shift>J + t to run the test method currently under the cursor
		vim.keymap.set(
			"n",
			"<leader>jt",
			"<Cmd> lua require('jdtls').test_nearest_method()<CR>",
			{ desc = "[J]ava [T]est Method" }
		)
		-- Set a Vim motion to <Space> + <Shift>J + t to run the test method that is currently selected in visual mode
		vim.keymap.set(
			"v",
			"<leader>jt",
			"<Esc><Cmd> lua require('jdtls').test_nearest_method(true)<CR>",
			{ desc = "[J]ava [T]est Method" }
		)
		-- Set a Vim motion to <Space> + <Shift>J + <Shift>T to run an entire test suite (class)
		vim.keymap.set(
			"n",
			"<leader>jT",
			"<Cmd> lua require('jdtls').test_class()<CR>",
			{ desc = "[J]ava [T]est Class" }
		)
		-- Set a Vim motion to <Space> + <Shift>J + u to update the project configuration
		vim.keymap.set("n", "<leader>ju", "<Cmd> JdtUpdateConfig<CR>", { desc = "[J]ava [U]pdate Config" })
	end,
}
