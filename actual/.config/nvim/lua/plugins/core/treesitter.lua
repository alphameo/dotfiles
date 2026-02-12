return {
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      vim.g.no_plugin_maps = true
      -- vim.g.no_python_maps = true
      -- vim.g.no_ruby_maps = true
      -- vim.g.no_rust_maps = true
      -- vim.g.no_go_maps = true
    end,
    config = function()
      local ts_obj = require "nvim-treesitter-textobjects"

      ts_obj.setup {
        select = {
          lookahead = true,
          selection_modes = {
            ["@parameter.outer"] = "v", -- charwise
            ["@function.outer"] = "V", -- linewise
            ["@class.outer"] = "<c-v>", -- blockwise
          },
          include_surrounding_whitespace = false,
        },
        move = {
          set_jumps = true,
        },
      }

      local map = vim.keymap.set

      -- SELECT
      local ts_obj_select = require "nvim-treesitter-textobjects.select"
      map({ "x", "o" }, "af", function()
        ts_obj_select.select_textobject("@function.outer", "textobjects")
      end, { desc = "outer function" })
      map({ "x", "o" }, "if", function()
        ts_obj_select.select_textobject("@function.inner", "textobjects")
      end, { desc = "inner function" })

      map({ "x", "o" }, "ac", function()
        ts_obj_select.select_textobject("@class.outer", "textobjects")
      end, { desc = "outer class" })
      map({ "x", "o" }, "ic", function()
        ts_obj_select.select_textobject("@class.inner", "textobjects")
      end, { desc = "inner class" })

      map({ "x", "o" }, "ao", function()
        ts_obj_select.select_textobject("@loop.outer", "textobjects")
      end, { desc = "outer loop" })
      map({ "x", "o" }, "io", function()
        ts_obj_select.select_textobject("@loop.inner", "textobjects")
      end, { desc = "inner loop" })

      -- Go to
      local move = require "nvim-treesitter-textobjects.move"
      map({ "n", "x", "o" }, "]f", function()
        move.goto_next_start("@function.outer", "textobjects")
      end, { desc = "Go to next function" })
      map({ "n", "x", "o" }, "[f", function()
        move.goto_previous_start("@function.outer", "textobjects")
      end, { desc = "Go to previous function" })

      map({ "n", "x", "o" }, "]c", function()
        move.goto_next_start("@class.outer", "textobjects")
      end, { desc = "Go to next class" })
      map({ "n", "x", "o" }, "[c", function()
        move.goto_previous_start("@class.outer", "textobjects")
      end, { desc = "Go to previous class" })

      map({ "n", "x", "o" }, "]o", function()
        move.goto_next_start("@loop.outer", "textobjects")
      end, { desc = "Go to next loop" })
      map({ "n", "x", "o" }, "[o", function()
        move.goto_previous_start("@loop.outer", "textobjects")
      end, { desc = "Goto previous loop" })

      map({ "n", "x", "o" }, "]p", function()
        move.goto_next_start("@parameter.inner", "textobjects")
      end, { desc = "Go to next parameter" })
      map({ "n", "x", "o" }, "[p", function()
        move.goto_previous_start("@parameter.inner", "textobjects")
      end, { desc = "Go to previous parameter" })
      -- map({ "n", "x", "o" }, "]d", function()
      --   move.goto_next_start("@conditional.outer", "textobjects")
      -- end)
      -- map({ "n", "x", "o" }, "[d", function()
      --   move.goto_previous_start("@conditional.outer", "textobjects")
      -- end)

      -- Swap
      local ts_obj_swap = require "nvim-treesitter-textobjects.swap"
      map("n", "grsf", function()
        ts_obj_swap.swap_next "@function.outer"
      end, { desc = "Swap function with next" })
      map("n", "grsF", function()
        ts_obj_swap.swap_previous "@function.outer"
      end, { desc = "Swap function with previous" })

      map("n", "grsp", function()
        ts_obj_swap.swap_next "@parameter.inner"
      end, { desc = "Swap parameter with next" })
      map("n", "<M-l>", function()
        ts_obj_swap.swap_next "@parameter.inner"
      end, { desc = "Swap parameter with next" })
      map("n", "grsP", function()
        ts_obj_swap.swap_previous "@parameter.inner"
      end, { desc = "Swap parameter with previous" })
      map("n", "<M-h>", function()
        ts_obj_swap.swap_previous "@parameter.inner"
      end, { desc = "Swap parameter with previous" })
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
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
        "javadoc",
        "c_sharp",
        "javascript",
        "jsdoc",
        "kotlin",
        "lua",
        "luadoc",
        "make",
        "python",
        "php",
        "phpdoc",
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
        "latex",
        "markdown",
        "markdown_inline",
        "mermaid",
        "scss",
        "typst",
        "xml",
        -- DATA SERIALIZATION
        "json",
        "json5",
        "toml",
        "yaml",
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
        "rasi",
        "ssh_config",
        "yuck",
      }

      require("nvim-treesitter").setup {
        ensure_installed = langs,
        highlight = { enable = true },
        indent = { enable = true },
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
    opts = {
      lang = {
        typst = { "// %s", "/* %s */" },
      },
    },
  },
}
