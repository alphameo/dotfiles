return {
  {
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      -- TODO: Enable when master branch become default
      -- { "nvim-treesitter/nvim-treesitter-textobjects", branch = "main" },
    },
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local langs = {
        -- LANGUAGES
        "bash",
        "c",
        "cpp",
        "cmake",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "java",
        "javascript",
        "kotlin",
        "lua",
        "luadoc",
        "make",
        "python",
        "php",
        "ron",
        "rust",
        "scheme",
        "sql",
        "typescript",
        "vim",
        "vimdoc",
        -- MARKUP
        "bibtex",
        "css",
        "html",
        "markdown",
        "markdown_inline",
        "mermaid",
        "scss",
        "xml",
        -- DATA
        "json",
        "jsonc",
        "json5",
        -- TOOLS
        "diff",
        "dockerfile",
        "gitignore",
        "git_config",
        "git_rebase",
        "gitcommit",
        "printf",
        "regex",
        "query",
        -- CONFIGURATIONS
        "dot",
        "hyprlang",
        "ini",
        "toml",
        "rasi",
        "ssh_config",
        "yuck",
        "yaml",
      }

      require("nvim-treesitter").setup {
        ensure_installed = langs,
        sync_install = false,
        auto_install = true,
        highlight = {
          enable = true,
          use_languagetree = true,
          additional_vim_regex_highlighting = false,
          disable = {},
        },
        indent = { enable = true },
        -- textobjects = { select = { enable = true, lookahead = true } },
      }

      require("nvim-treesitter").install(langs)

      vim.api.nvim_create_autocmd("FileType", {
        pattern = langs,
        callback = function()
          vim.treesitter.start()
          vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
          vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
        desc = "triggers treesitter on filetype detection",
      })

      vim.api.nvim_create_user_command("TSInfo", function()
        vim.cmd "checkhealth nvim-treesitter"
      end, { desc = "treesitter information (checkhealth)" })
      vim.api.nvim_create_user_command("TSInspect", function()
        vim.cmd "Inspect"
      end, { desc = "treesitter inspect token" })
      vim.api.nvim_create_user_command("TSInspectTree", function()
        vim.cmd "InspectTree"
      end, { desc = "treesitter show tree" })

      local map = vim.keymap.set
      map("n", "gS", ":InspectTree<CR>", { silent = true, desc = "Syntax Tree" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    lazy = true,
    event = "VeryLazy",
    opts = {
      enable = true,
      mode = "topline",
      line_numbers = true,
    },
  },
  {
    "folke/ts-comments.nvim",
    lazy = true,
    event = "VeryLazy",
    config = function()
      require("ts-comments").setup()
    end,
  },
}
