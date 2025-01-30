return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    vim.diagnostic.config {
      signs = {
        text = {
          [vim.diagnostic.severity.ERROR] = "",
          [vim.diagnostic.severity.WARN] = "",
          [vim.diagnostic.severity.INFO] = "",
          [vim.diagnostic.severity.HINT] = "󰌵",
        },
      },
    }

    vim.cmd [[highlight DapBreakpointColor guifg=#fa4848]]
    vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapBreakpointColor" })
    vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapBreakpointColor" })
    vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapBreakpointColor" })

    vim.cmd.colorscheme "onedark"

    local config = {
      style = "dark", -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
      cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
    }

    local onedark = require "onedark"
    onedark.setup(config)
    onedark.load()

    -- vim.cmd [[highlight DiagnosticVirtualTextError guibg=none]]
    -- vim.cmd [[highlight DiagnosticVirtualTextWarn guibg=none]]
    -- vim.cmd [[highlight DiagnosticVirtualTextInfo guibg=none]]
    -- vim.cmd [[highlight DiagnosticVirtualTextHint guibg=none]]

    local toggle_transparency = function()
      config.transparent = not config.transparent
      onedark.setup(config)
      onedark.load()
    end

    vim.keymap.set(
      "n",
      "<leader>at",
      toggle_transparency,
      { noremap = true, silent = true, desc = "Toggle Background Transparency" }
    )
    vim.keymap.set(
      "n",
      "<leader>as",
      '<Cmd>lua require("onedark").toggle()<CR>',
      { silent = true, desc = "Toggle Onedark-theme Style" }
    )
  end,
}
