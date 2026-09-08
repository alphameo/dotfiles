return {
  "L3MON4D3/LuaSnip",
  version = "v2.*",
  build = "make install_jsregexp",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },
  lazy = true,
  event = { "InsertEnter", "CmdlineEnter" },
  config = function()
    local ls = require "luasnip"
    ls.setup {
      history = true,
      delete_check_events = "TextChanged",
    }
    require("luasnip.loaders.from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").lazy_load { paths = { "./snippets" } }
    require("luasnip.loaders.from_lua").lazy_load {
      paths = vim.fn.stdpath "config" .. "/lua/snippets",
    }

    --   local map = vim.keymap.set
    --   map({ "i", "s" }, "<M-e>", function()
    --     if ls.expand_or_jumpable() then
    --       ls.expand_or_jump()
    --     end
    --   end)
    --   map({ "i", "s" }, "<M-p>", function()
    --     if ls.jumpable(-1) then
    --       ls.jump(-1)
    --     end
    --   end, { silent = true, desc = "Previous Snippet stop" })
    --   map({ "i", "s" }, "<M-n>", function()
    --     if ls.jumpable(1) then
    --       ls.jump(1)
    --     end
    --   end, { silent = true, desc = "Next Snippet stop" })
  end,
}
