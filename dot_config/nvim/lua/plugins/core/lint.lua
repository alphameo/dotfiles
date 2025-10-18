return {
  "mfussenegger/nvim-lint",
  lazy = true,
  event = { "BufReadPre", "BufNewFile" },
  cmd = { "LintInfo" },
  config = function()
    local lint = require "lint"
    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    lint.linters_by_ft = {
      c = { "cpplint" },
      cpp = { "cpplint" },
      cmake = { "cmakelint" },
      html = { "htmlhint" },
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

    lint.linters.mypy.args = {
      "--show-column-numbers",
      "--show-error-end",
      "--hide-error-context",
      "--no-color-output",
      "--no-error-summary",
      "--no-pretty",
      "--python-executable",
      os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX" or "/usr" .. "bin/mypy",
    }
    lint.linters.sqlfluff.args = {
      "lint",
      "--format=json",
      -- NOTE: flag or direct into file
      -- `*/.sqlfluff`
      -- [sqlfluff]
      -- dialect = mysql
      --------------------
      -- "--dialect=postgres",
    }

    vim.env.eslint_d_ppid = vim.fn.getpid()
    lint.linters.eslint_d.args = {
      "--format",
      "json",
      "--config",
      os.getenv "ESLINT_DEFAULT_CONFIG",
      "--stdin",
      "--stdin-filename",
      function()
        return vim.api.nvim_buf_get_name(0)
      end,
    }

    lint.linters.luacheck.args = {
      "--formatter",
      "plain",
      "--codes",
      "--globals",
      "vim",
      "--ranges",
      "-",
    }

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.api.nvim_create_user_command("Lint", function()
      lint.try_lint()
      vim.notify "Linted"
    end, {})
    vim.keymap.set("n", "gl", ":Lint<CR>", { silent = true, desc = "Lint file" })

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
