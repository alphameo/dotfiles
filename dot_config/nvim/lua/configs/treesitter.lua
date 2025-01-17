return {
  "nvim-treesitter/nvim-treesitter",
  -- version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  opts = function(_, opts)
    opts.highlight = opts.highlight or {}
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "bibtex" })
    end
    if type(opts.highlight.disable) == "table" then
      vim.list_extend(opts.highlight.disable, { "latex" })
    else
      opts.highlight.disable = { "latex" }
    end
  end,

  config = function()
    require("nvim-treesitter.configs").setup {

      ensure_installed = {
        "lua",
        "java",
        "c",
        "cpp",
        "kotlin",
        "python",
        "ninja",
        "rst",
        "make",
        "cmake",
        "html",
        "css",
        "javascript",
        "typescript",
        "tsx",
        "php",
        "sql",
        "luadoc",
        "vim",
        "vimdoc",
        "regex",
        "printf",
        "markdown",
        "markdown_inline",
        "bash",
        "toml",
        "yaml",
        "xml",
        "json5",
        "diff",
        "gitignore",
        "bibtex",
        "dockerfile",
      },

      sync_install = false,

      auto_install = true,

      indent = {
        enable = true,
      },

      highlight = {
        enable = true,
        use_language_tree = true,
        disable = function(lang, buf)
          if lang == "html" then
            print "disabled"
            return true
          end

          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            vim.notify(
              "File larger than 100KB treesitter disabled for performance",
              vim.log.levels.WARN,
              { title = "Treesitter" }
            )
            return true
          end
        end,

        additional_vim_regex_highlighting = { "markdown", "ruby" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
      textobjects = {
        move = {
          enable = true,
          goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer", ["]a"] = "@parameter.inner" },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]A"] = "@parameter.inner" },
          goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer", ["[a"] = "@parameter.inner" },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[A"] = "@parameter.inner" },
        },
      },
    }
  end,
}
