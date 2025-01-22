return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    -- stylua: ignore
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local map = vim.keymap.set
          local b = e.buf
          local telescope = require("telescope.builtin")
          local lsp = vim.lsp
          local lsp_b = lsp.buf

          map({ "n", "i", "v" }, "<C-k>", lsp_b.hover, { buffer = b, desc = "Show Doc Hover" })
          map({ "n", "i", "v" }, "<C-S-k>", lsp_b.signature_help, { buffer = b, desc = "Show Signature Help" })

          map("n", "gd", telescope.lsp_definitions, { buffer = b, desc = "Go to Definitions" })
          map("n", "gD", lsp_b.declaration, { buffer = b, desc = "Go to Declaration" })
          map("n", "gI", telescope.lsp_implementations, { buffer = b, desc = "Go to Implementations" })
          map("n", "gr", telescope.lsp_references, { buffer = b, desc = "Go to References" })
          map("n", "gt", telescope.lsp_type_definitions, { buffer = b, desc = "Go to Type Definition" })
          map("n", "gb", "<C-o>", { buffer = b, desc = "Go Back" })

          map("n", "<leader>csd", telescope.lsp_document_symbols, { buffer = b, desc = "Code Symbols Document" })
          map("n", "<leader>csw", telescope.lsp_dynamic_workspace_symbols, { buffer = b, desc = "Code Symbols Workspace" })

          map({ "n", "v" }, "<leader>ca", lsp_b.code_action, { buffer = b, desc = "Code Actions" })

          map("n", "<leader>cr", lsp_b.rename, { buffer = b, desc = "Code Rename" })
          map("n", "<F2>", lsp_b.rename, { buffer = b, desc = "Code Rename" })

          if lsp.inlay_hint then
            lsp.inlay_hint.enable(true, { 0 })
            map("n", "<leader>ah", function()
              lsp.inlay_hint.enable(not lsp.inlay_hint.is_enabled(), { 0 })
            end, { buffer = b, desc = "Toggle Inlay Hints" })
          end

          map("n", "[d", vim.diagnostic.goto_next, { buffer = b })
          map("n", "]d", vim.diagnostic.goto_prev, { buffer = b })
        end,
      })
    end,
  },
}
