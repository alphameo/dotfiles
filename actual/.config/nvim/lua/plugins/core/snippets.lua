return {
  {
    "L3MON4D3/LuaSnip",
    version = "v2.*",
    build = "make install_jsregexp",
    dependencies = {
      "rafamadriz/friendly-snippets",
    },
    lazy = true,
    event = { "InsertEnter", "CmdlineEnter" },
    opts = {
      history = true,
      delete_check_events = "TextChanged",
    },
  },
  {
    "rafamadriz/friendly-snippets",
    lazy = true,
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
      require("luasnip.loaders.from_lua").lazy_load {
        paths = vim.fn.stdpath "config" .. "/lua/snippets",
      }
    end,
  },
}
