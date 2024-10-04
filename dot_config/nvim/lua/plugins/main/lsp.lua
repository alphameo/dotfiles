return {
	{
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	},
	{
		"williamboman/mason-lspconfig.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"jdtls",
					"html",
					"cssls",
					"cssmodules_ls",
					"css_variables",
					"ts_ls",
					"eslint",
				},
			})
		end,
	},
	{
		"jay-babu/mason-nvim-dap.nvim",
		config = function()
			require("mason-nvim-dap").setup({
				ensure_installed = { "java-debug-adapter", "java-test" },
			})
		end,
	},
	{
		"mfussenegger/nvim-jdtls",
		ft = "java", -- Enable only on .java file extensions
		dependencies = {
			"mfussenegger/nvim-dap",
		},
	},
	{
		"neovim/nvim-lspconfig",
		opts = {
			inlay_hints = { enabled = true },
		},
		config = function()
			local lspconfig = require("lspconfig")
			local capabilities = require("cmp_nvim_lsp").default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
				settings = {
					Lua = {
						completion = {
							callSnippet = "Replace",
						},
						-- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
						diagnostics = { disable = { "missing-fields" } },
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = {
								"${3rd}/luv/library",
								unpack(vim.api.nvim_get_runtime_file("", true)),
							},
						},
						format = {
							enable = false,
						},
						hint = { enable = true },
					},
				},
			})

			lspconfig.ts_ls.setup({
				init_options = {
					plugins = {
						{
							name = "@vue/typescript-plugin",
							location = "/usr/local/lib/node_modules/@vue/typescript-plugin",
							languages = { "javascript", "typescript", "vue" },
						},
					},
				},
				filetypes = {
					"javascript",
					"typescript",
					"vue",
				},
			})
			lspconfig.eslint.setup({
				on_attach = function(client, bufnr)
					vim.api.nvim_create_autocmd("BufWritePre", {
						buffer = bufnr,
						command = "EslintFixAll",
					})
				end,
			})

			--Enable (broadcasting) snippet capability for completion
			local textDocCapabilities = vim.lsp.protocol.make_client_capabilities()
			textDocCapabilities.textDocument.completion.completionItem.snippetSupport = true

			lspconfig.html.setup({
				capabilities = textDocCapabilities,
			})

			lspconfig.cssls.setup({
				capabilities = textDocCapabilities,
			})
			lspconfig.css_variables.setup({})
			lspconfig.cssmodules_ls.setup({})

			vim.keymap.set("n", "<leader>k", vim.lsp.buf.hover, { desc = "Show doc hover" })
			vim.keymap.set({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { desc = "Show doc hover" })
			vim.keymap.set("n", "<leader>K", vim.lsp.buf.signature_help, { desc = "Show Signature Help" })

			vim.keymap.set("n", "<leader>cd", vim.lsp.buf.definition, { desc = "[C]ode [D]efinition" })
			vim.keymap.set("n", "<leader>cD", vim.lsp.buf.declaration, { desc = "[C]ode [D]eclaration" })
			vim.keymap.set(
				"n",
				"<leader>ci",
				require("telescope.builtin").lsp_implementations,
				{ desc = "[C]ode [I]mplementations" }
			)
			vim.keymap.set(
				"n",
				"<leader>cr",
				require("telescope.builtin").lsp_references,
				{ desc = "[C]ode [R]eferences" }
			)

			vim.keymap.set(
				"n",
				"<leader>csd",
				require("telescope.builtin").lsp_document_symbols,
				{ desc = "[C]ode [S]ymbols [D]ocument" }
			)
			vim.keymap.set(
				"n",
				"<leader>csw",
				require("telescope.builtin").lsp_dynamic_workspace_symbols,
				{ desc = "[C]ode [S]ymbols [W]orkspace" }
			)

			vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })

			vim.keymap.set("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
			vim.keymap.set("n", "<F2>", vim.lsp.buf.rename, { desc = "Code [R]ename" })
			vim.lsp.buf.signature_help()
			if vim.lsp.inlay_hint then
				vim.lsp.inlay_hint.enable(true, { 0 })
				vim.keymap.set("n", "<leader>ch", function()
					vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
				end, { desc = "[C]ode Toggle Inlay [H]ints" })
			end
		end,
	},
}
