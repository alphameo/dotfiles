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
    end, { desc = "Trigger linting" })

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
