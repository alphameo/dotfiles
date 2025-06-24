return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  branch = "main",
  build = ":TSUpdate",
  config = function()
    local langs = {
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
      "yuck",
    }

    require("nvim-treesitter").setup {
      ensure_installed = langs,
      sync_install = false,
      auto_install = false,
      highlight = {
        enable = true,
        use_languagetree = true,
        additional_vim_regex_highlighting = false,
      },
      indent = {
        enable = true,
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "gnn",
          node_incremental = "grn",
          scope_incremental = "grc",
          node_decremental = "grm",
        },
      },
    }

    require("nvim-treesitter").install(langs)

    vim.api.nvim_create_autocmd("FileType", {
      pattern = langs,
      callback = function()
        vim.treesitter.start()
      end,
    })

    local map = vim.keymap.set
    map("n", "<leader>ct", ":InspectTree<CR>", { silent = true, desc = "Code Inspec Tree" })
  end,
}
