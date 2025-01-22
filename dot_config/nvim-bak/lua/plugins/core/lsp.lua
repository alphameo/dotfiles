return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = true },
      codelens = { enabled = true },
    },
    config = function()
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local map = vim.keymap.set
          local b = e.buf

          map({ "n", "i", "v" }, "<C-k>", vim.lsp.buf.hover, { buffer = b, desc = "Show Doc Hover" })
          map({ "n", "i", "v" }, "<C-S-k>", vim.lsp.buf.signature_help, { buffer = b, desc = "Show Signature Help" })

          map("n", "<leader>gd", require("telescope.builtin").lsp_definitions, { buffer = b, desc = "Goto Definition" })
          map("n", "gd", function()
            require("telescope.builtin").lsp_definitions { reuse_win = true }
          end, { buffer = b, desc = "Goto Definition" })

          map("n", "<leader>gD", vim.lsp.buf.declaration, { buffer = b, desc = "Goto Declaration" })
          map("n", "gD", vim.lsp.buf.declaration, { buffer = b, desc = "Goto Declaration" })

          map(
            "n",
            "<leader>gI",
            require("telescope.builtin").lsp_implementations,
            { buffer = b, desc = "Goto Implementations" }
          )
          map("n", "gI", function()
            require("telescope.builtin").lsp_implementations { reuse_win = true }
          end, { buffer = b, desc = "Goto Implementations" })

          map("n", "<leader>gr", require("telescope.builtin").lsp_references, { buffer = b, desc = "Goto References" })
          map("n", "gr", function()
            require("telescope.builtin").lsp_references { reuse_win = true }
          end, { buffer = b, desc = "Goto References" })

          map(
            "n",
            "<leader>gt",
            require("telescope.builtin").lsp_type_definitions,
            { buffer = b, desc = "Goto Type defenition" }
          )
          map("n", "gt", function()
            require("telescope.builtin").lsp_type_definitions { reuse_win = true }
          end, { buffer = b, desc = "Goto Type defenition" })

          map("n", "<leader>gb", "<C-o>", { buffer = b, desc = "Go Back" })
          map("n", "gb", "<C-o>", { buffer = b, desc = "Go Back" })

          map(
            "n",
            "<leader>csd",
            require("telescope.builtin").lsp_document_symbols,
            { buffer = b, desc = "Code Symbols Document" }
          )
          map(
            "n",
            "<leader>csw",
            require("telescope.builtin").lsp_dynamic_workspace_symbols,
            { buffer = b, desc = "Code Symbols Workspace" }
          )

          map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, { buffer = b, desc = "Code Actions" })

          map("n", "<leader>cr", vim.lsp.buf.rename, { buffer = b, desc = "Code Rename" })
          map("n", "<F2>", vim.lsp.buf.rename, { buffer = b, desc = "Code Rename" })

          if vim.lsp.inlay_hint then
            vim.lsp.inlay_hint.enable(true, { 0 })
            map("n", "<leader>ah", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled(), { 0 })
            end, { buffer = b, desc = "Toggle Inlay Hints" })
          end
          vim.keymap.set("n", "[d", vim.diagnostic.goto_next, { buffer = b })
          vim.keymap.set("n", "]d", vim.diagnostic.goto_prev, { buffer = b })
        end,
      })
    end,
  },
}
