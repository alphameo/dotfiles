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

        map({ "n", "i", "v" }, "<C-k>", lsp_b.hover, opts "Show Doc Hover")
        map({ "n", "i", "v" }, "<C-S-k>", lsp_b.signature_help, opts "Show Signature Help")

        map("n", "gd", telescope.lsp_definitions, opts "Go to Definitions")
        map("n", "gD", lsp_b.declaration, opts "Go to Declaration")
        map("n", "gI", telescope.lsp_implementations, opts "Go to Implementations")
        map("n", "gr", telescope.lsp_references, opts "Go to References")
        map("n", "gt", telescope.lsp_type_definitions, opts "Go to Type Definition")
        map("n", "gs", telescope.lsp_document_symbols, { desc = "Go to Document Symbols" })
        map("n", "gS", telescope.lsp_dynamic_workspace_symbols, { desc = "Go to Workspace Symbols" })
        map("n", "gb", "<C-o>", opts "Go Back")

        map("n", "<leader>cd", telescope.diagnostics, opts "Code Diagnostics")
        map("n", "<leader>cq", telescope.quickfix, { desc = "Code Quickfix" })

        map("n", "<leader>ct", telescope.treesitter, { desc = "Find Files" })
        map({ "n", "v" }, "<leader>ca", lsp_b.code_action, opts "Code Actions")

        map("n", "<leader>cr", lsp_b.rename, opts "Code Rename")
        map("n", "<F2>", lsp_b.rename, opts "Code Rename")

        map("n", "<leader>ah", function()
          lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
        end, opts "Toggle Inlay Hints")

        if lsp.inlay_hint then
          lsp.inlay_hint.enable(true, { 0 })
        end

        map("n", "[d", vim.diagnostic.goto_prev, opts "Previous Diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, opts "Next Diagnostic")
      end,
    })
  end,
}
