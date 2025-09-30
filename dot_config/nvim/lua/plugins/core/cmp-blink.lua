return {
  "saghen/blink.cmp",
  dependencies = {
    {
      "L3MON4D3/LuaSnip",
      version = "v2.*",
      build = "make install_jsregexp",
      dependencies = {
        "rafamadriz/friendly-snippets",
        config = function()
          require("luasnip.loaders.from_vscode").lazy_load()
        end,
      },
      opts = { history = true, delete_check_events = "TextChanged" },
    },
  },
  version = "1.*",
  lazy = true,
  event = { "InsertEnter", "CmdlineEnter" },
  opts = {
    keymap = {
      preset = "default",
      ["<C-space>"] = { "show", "hide", "fallback" },
      ["<C-k>"] = { "select_prev", "fallback" },
      ["<C-j>"] = { "select_next", "fallback" },
      ["<C-d>"] = { "show_documentation", "hide_documentation", "fallback" },
      ["<C-s>"] = { "show_signature", "hide_signature" }, -- replace default signature
      ["<C-e>"] = { "scroll_documentation_down", "fallback" },
      ["<C-y>"] = { "scroll_documentation_up", "fallback" },
      ["<Tab>"] = {
        function(cmp)
          if cmp.snippet_active() then
            return cmp.accept()
          else
            return cmp.select_and_accept()
          end
        end,
        "fallback",
      },
      ["<C-]>"] = { "snippet_forward", "fallback" },
      ["<C-["] = { "snippet_backward", "fallback" },
      ["<C-Tab>"] = { "snippet_forward", "fallback" },
      ["<C-S-Tab>"] = { "snippet_backward", "fallback" },
    },
    signature = {
      enabled = true,
      trigger = {
        show_on_trigger_character = false,
        show_on_insert = false,
        show_on_insert_on_trigger_character = false,
      },
      window = {
        treesitter_highlighting = true,
        show_documentation = true,
      },
    },
    appearance = {
      -- "mono" | "normal"
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 0,
        treesitter_highlighting = true,
      },
      menu = {
        direction_priority = { "s", "n" },
        auto_show = true,
        draw = {
          treesitter = { "lsp" },
          columns = {
            { "kind_icon" },
            { "kind" },
            {
              "label",
              "label_description",
            },
            { "source_id" },
          },
        },
      },
      ghost_text = {
        enabled = false,
      },
      list = {
        selection = {
          preselect = true,
          auto_insert = false,
        },
      },
    },
    cmdline = {
      enabled = true,
      keymap = {
        ["<C-Space>"] = { "show", "hide", "fallback" },
        ["<Tab>"] = { "accept", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-j>"] = { "select_next", "fallback" },
      },
      completion = {
        menu = { auto_show = true },
        ghost_text = { enabled = false },
      },
    },
    sources = {
      default = {
        "lsp",
        "path",
        "snippets",
        "buffer",
      },
      per_filetype = {
        sql = { "snippets", "dadbod", "buffer" },
      },

      providers = {
        dadbod = { name = "Dadbod", module = "vim_dadbod_completion.blink" },
      },
    },
    snippets = { preset = "luasnip" },
    -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
    -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
    -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
