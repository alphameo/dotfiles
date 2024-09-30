return {
	"mfussenegger/nvim-dap",
	dependencies = {
		-- ui plugins to make debugging simplier
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		-- gain access to the dap plugin and its functions
		local dap = require("dap")
		-- gain access to the dap ui plugin and its functions
		local dapui = require("dapui")

		-- Setup the dap ui with default configuration
		dapui.setup()

		-- setup an event listener for when the debugger is launched
		dap.listeners.before.launch.dapui_config = function()
			-- when the debugger is launched open up the debug ui
			dapui.open()
		end

		-- set a vim motion for <Space> + d + b to toggle a breakpoint at the line where the cursor is currently on
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Toggle [D]ebug [B]reakpoint" })

		-- set a vim motion for <Space> + d + s to start the debugger and launch the debugging ui
		vim.keymap.set("n", "<leader>dus", dap.continue, { desc = "[D]ebug [U]i [S]tart" })

		-- set a vim motion to close the debugging ui
		vim.keymap.set("n", "<leader>duq", dapui.close, { desc = "[D]ebug [U]i [Q]uit" })
	end,
}
