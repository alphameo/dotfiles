local icons = {
  Error = "",
  Warn = "",
  Hint = "󰌵",
  Info = "",
}

local signs = {
  text = {},
  numhl = {},
  texthl = {},
}

for type, icon in pairs(icons) do
  local hl = "DiagnosticSign" .. type
  local severity = vim.diagnostic.severity[string.upper(type)]

  signs.text[severity] = icon
  signs.numhl[severity] = hl
  signs.texthl[severity] = hl
end

vim.diagnostic.config {
  underline = true,
  virtual_text = {
    source = true,
    spacing = 0,
  },
  float = {
    source = true,
    border = "rounded",
  },
  update_in_insert = true,
  severity_sort = true,
  signs = signs,
}

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local lint = require "lint"
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cF", function()
      lint.try_lint()
    end, { desc = "Code lint" })

    -- INFO: command for Linters checking
    vim.api.nvim_create_user_command("LintInfo", function()
      local out = "\n"

      local cur_ft = vim.bo.filetype
      local cur_linters = lint.linters_by_ft[cur_ft]
      if cur_linters then
        out = out .. "Linters for " .. cur_ft .. ": " .. table.concat(cur_linters, ", ") .. "\n"
      else
        out = out .. "No linters configured for filetype: " .. cur_ft .. "\n"
      end

      local linters_by_ft = lint.linters_by_ft
      local linter_map = {}
      for ft, linters in pairs(linters_by_ft) do
        for _, l in ipairs(linters) do
          if not linter_map[l] then
            linter_map[l] = { ft }
          elseif not vim.tbl_contains(linter_map[l], ft) then
            table.insert(linter_map[l], ft)
          end
        end
      end

      for linter, ft in pairs(linter_map) do
        out = out .. string.format("%s (%s)\n", linter, table.concat(ft, ", "))
      end
      vim.notify(out, vim.log.levels.INFO, { title = "Nvim-lint" })
    end, {})
  end,
}
