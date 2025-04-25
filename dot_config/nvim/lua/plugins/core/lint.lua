return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPost", "BufWritePost", "BufNewFile" },
  cmd = { "LintInfo" },
  config = function()
    local lint = require "lint"
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters_by_ft = {
      c = { "cpplint" },
      cpp = { "cpplint" },
      cmake = { "cmakelint" },
      html = { "hmtlhint" },
      kotlin = { "ktlint" },
      lua = { "luacheck" },
      markdown = { "markdownlint-cli2" },
      php = { "phpcs" },
      python = { "mypy" },
      sql = { "sqlfluff" },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
    }

    lint.linters.mypy.args = vim.tbl_deep_extend(
      "force",
      lint.linters.mypy.args,
      { "--python-executable", os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX" or "/usr" .. "bin/mypy" }
    )

    vim.env.ESLINT_D_PPID = vim.fn.getpid()
    lint.linters.eslint_d = {
      cmd = "eslint_d",
      stdin = true,
      args = {
        "--config",
        os.getenv "ESLINT_D_DEFAULT_CONFIG",
      },
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    local map = vim.keymap.set

    map("n", "<leader>cl", lint.try_lint, { desc = "Code Lint" })

    map("n", "<leader>al", function()
      if vim.diagnostic.config().virtual_text then
        vim.diagnostic.config { virtual_text = false }
      else
        vim.diagnostic.config { virtual_text = true }
      end
    end, { silent = true, desc = "Toggle Lint Virtual Text" })

    map("n", "<leader>aL", function()
      if not vim.diagnostic.is_enabled() then
        vim.diagnostic.enable(true)
      else
        vim.diagnostic.enable(false)
      end
    end, { silent = true, desc = "Toggle Linting" })

    -- INFO: command for Linters checking
    vim.api.nvim_create_user_command("LintInfo", function()
      local out = "\n"

      local cur_ft = vim.bo.filetype
      local cur_linters = lint.linters_by_ft[cur_ft]
      if cur_linters then
        out = out .. "Linters for " .. cur_ft .. ":\n"
        for i, linter in ipairs(cur_linters) do
          out = out .. i .. ") " .. linter .. "\nconf = " .. vim.inspect(require("lint").linters[linter])
        end
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

      out = out .. "\n\nList of configured linters:\n"
      for linter, ft in pairs(linter_map) do
        out = out .. string.format("\t- %s (%s)\n", linter, table.concat(ft, ", "))
      end

      vim.notify(out, vim.log.levels.INFO, { title = "Nvim-lint" })

      -- TODO: check noice installed
      local noice = require "noice"
      if noice then
        noice.cmd "last"
      end
    end, {})
  end,
}
