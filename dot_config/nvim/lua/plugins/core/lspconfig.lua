return {
  "neovim/nvim-lspconfig",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  opts = {
    inlay_hints = { enabled = true },
    codelens = { enabled = true },
  },
  config = function()
    require("lsp").setup()

    local del_map = vim.keymap.del
    del_map("n", "grn") -- Rename
    del_map({ "n", "v" }, "gra") -- Code Actions
    del_map("n", "grr") -- Go to References
    del_map("n", "gri") -- Fo to Implementation
    del_map("n", "gO") -- Document Symbols
    del_map("i", "<C-s>") -- Signature Help

    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("UserLspConfig", {}),
      callback = function(args)
        local lsp = vim.lsp
        local lsp_b = lsp.buf
        local map = vim.keymap.set
        local opts = function(desc)
          return { buffer = args.buf, desc = desc }
        end

        local telescope = require "telescope.builtin"

        map("n", "<C-k>", lsp_b.hover, opts "Show Doc Hover")
        map("n", "K", lsp_b.hover, opts "Show Doc Hover")
        map("i", "<C-S-k>", lsp_b.signature_help, opts "Show Signature Help")

        map("n", "gd", telescope.lsp_definitions, opts "Go to Definitions")
        map("n", "gD", lsp_b.declaration, opts "Go to Declaration")
        map("n", "gI", telescope.lsp_implementations, opts "Go to Implementations")
        map("n", "gr", telescope.lsp_references, opts "Go to References")
        map("n", "gt", telescope.lsp_type_definitions, opts "Go to Type Definition")
        map("n", "gb", "<C-o>", opts "Go Back")

        map("n", "<leader>cs", telescope.lsp_document_symbols, opts "Code Document Symbols")
        map("n", "<leader>cS", telescope.lsp_dynamic_workspace_symbols, opts "Code Workspace Symbols")
        map("n", "<leader>cd", telescope.diagnostics, opts "Code Diagnostics")
        map("n", "<leader>cq", telescope.quickfix, opts "Code Quickfix")

        map({ "n", "v" }, "<leader>ca", lsp_b.code_action, opts "Code Actions")
        map("n", "<leader>cr", lsp_b.rename, opts "Code Rename")
        map("n", "<F2>", lsp_b.rename, opts "Code Rename")

        map("n", "<leader>ah", function()
          lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
        end, opts "Toggle Inlay Hints")

        map("n", "<leader>lR", ":LspRestart<CR>", { silent = true, desc = "LSP Restart" })

        if lsp.inlay_hint then
          lsp.inlay_hint.enable(true, { 0 })
        end
      end,
    })
  end,
}
