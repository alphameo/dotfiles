return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has "win32" == 1 or vim.fn.executable "make" == 0 then
          return
        end
        return "make install_jsregexp"
      end)(),
      dependencies = {
        {
          "rafamadriz/friendly-snippets",
          config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
          end,
        },
      },
    },
    "saadparwaiz1/cmp_luasnip",

    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-cmdline",
  },

  opts = function(_, opts)
    opts.auto_brackets = opts.auto_brackets or {}
    table.insert(opts.auto_brackets, "python")
  end,

  config = function()
    local cmp = require "cmp"
    local luasnip = require "luasnip"
    luasnip.config.setup {}

    local kind_icons = {
      Text = "󰉿 ",
      Method = "m",
      Function = "󰊕",
      Constructor = " ",
      Field = " ",
      Variable = "󰆧 ",
      Class = "󰌗 ",
      Interface = " ",
      Module = " ",
      Property = " ",
      Unit = " ",
      Value = "󰎠 ",
      Enum = " ",
      Keyword = "󰌋 ",
      Snippet = " ",
      Color = "󰏘 ",
      File = "󰈙",
      Reference = " ",
      Folder = "󰉋 ",
      EnumMember = " ",
      Constant = "󰇽 ",
      Struct = " ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰊄",
    }

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },

      completion = { completeopt = "menu,menuone,noinsert" },

      mapping = cmp.mapping.preset.insert {
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<Tab>"] = cmp.mapping.confirm { select = true },

        ["<C-Space>"] = cmp.mapping.complete {},

        ["<C-j>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_locally_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { "i", "s" }),
        ["<C-k>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.locally_jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { "i", "s" }),
      },

      sources = {
        {
          name = "lazydev",
          group_index = 0,
        },
        { name = "nvim_lsp" },
        { name = "buffer" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
        { name = "nvim_lsp_signature_help" },
      },

      formatting = {
        fields = { "kind", "abbr", "menu" },
        format = function(entry, vim_item)
          vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
          vim_item.menu = ({
            nvim_lsp = "[lsp]",
            luasnip = "[snip]",
            buffer = "[bufr]",
            path = "[path]",
          })[entry.source.name]
          return vim_item
        end,
      },

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
        matching = { disallow_symbol_nonprefix_matching = false },
      }),
    }
  end,
}
