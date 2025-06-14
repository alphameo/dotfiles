return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release doesn't work on windows
  lazy = true,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  cmd = { "TSUpdate", "TSInstall", "TSBufEnable", "TSBufDisable" },
  build = ":TSUpdate",
  config = function()
    local config = require "nvim-treesitter.configs"
    config.setup {
      ensure_installed = {
        "lua",
        "java",
        "c",
        "cpp",
        "kotlin",
        "python",
        "go",
        "gomod",
        "gosum",
        "gowork",
        "rust",
        "ron",
        "make",
        "cmake",
        "html",
        "css",
        "scss",
        "javascript",
        "typescript",
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
        "hyprlang",
        "yuck"
      },
      highlight = {
        enable = true,
        use_languagetree = true,
      },
      indent = {
        enable = true,
      },
    }
  end,
}
