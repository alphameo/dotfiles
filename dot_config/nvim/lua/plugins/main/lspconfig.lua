local M = {}

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
	documentationFormat = { "markdown", "plaintext" },
	snippetSupport = true,
	preselectSupport = true,
	insertReplaceSupport = true,
	labelDetailsSupport = true,
	deprecatedSupport = true,
	commitCharactersSupport = true,
	tagSupport = { valueSet = { 1 } },
	resolveSupport = {
		properties = {
			"documentation",
			"detail",
			"additionalTextEdits",
		},
	},
}

M.on_attach = function(_, bufnr)
	local map = vim.keymap.set

	map("n", "<leader>k", vim.lsp.buf.hover, { desc = "Show doc hover" })
	map({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { desc = "Show doc hover" })
	-- map("n", "<leader>K", vim.lsp.buf.signature_help, { desc = "Show signature help" })

	map("n", "<leader>gd", vim.lsp.buf.definition, { desc = "[G]oto [D]efinition" })
	map("n", "<leader>gD", vim.lsp.buf.declaration, { desc = "[G]oto [D]eclaration" })
	map("n", "<leader>gi", require("telescope.builtin").lsp_implementations, { desc = "[G]oto [I]mplementations" })
	map("n", "<leader>gr", require("telescope.builtin").lsp_references, { desc = "[G]oto [R]eferences" })
	map("n", "<leader>gb", "<C-o>", { desc = "[G]oto [B]ack" })

	map("n", "<leader>csd", require("telescope.builtin").lsp_document_symbols, { desc = "[C]ode [S]ymbols [D]ocument" })
	map(
		"n",
		"<leader>csw",
		require("telescope.builtin").lsp_dynamic_workspace_symbols,
		{ desc = "[C]ode [S]ymbols [W]orkspace" }
	)

	map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { desc = "[C]ode [A]ctions" })

	map("n", "<leader>cr", vim.lsp.buf.rename, { desc = "[C]ode [R]ename" })
	map("n", "<F2>", vim.lsp.buf.rename, { desc = "Code [R]ename" })

	if vim.lsp.inlay_hint then
		vim.lsp.inlay_hint.enable(true, { 0 })
		map("n", "<leader>ch", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
		end, { desc = "[C]ode Toggle Inlay [H]ints" })
	end
end

M.on_init = function(client, _)
	if client.supports_method("textDocument/semanticTokens") then
		client.server_capabilities.semanticTokensProvider = nil
	end
end

return M
