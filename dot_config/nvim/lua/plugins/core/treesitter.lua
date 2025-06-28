return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  event = { "BufReadPre", "BufNewFile" },
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
        enable = false,
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
    map("n", "<leader>ct", ":InspectTree<CR>", { silent = true, desc = "Code Inspect Tree" })
  end,
}
