return {
  "folke/noice.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  lazy = true,
  event = "VeryLazy",
  config = function()
    -- HACK: noice shows messages from before it was enabled,
    -- but this is not ideal when Lazy is installing plugins,
    -- so clear the messages in this case.
    if vim.o.filetype == "lazy" then
      vim.cmd [[messages clear]]
    end

    local noice = require "noice"
    local map = vim.keymap.set

    noice.setup {
      presets = {
        bottom_search = true,
        command_palette = false,
        long_message_to_split = true,
        inc_rename = false,
        lsp_doc_border = false,
      },
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = false, -- requires hrsh7th/nvim-cmp
        },
        progress = { enabled = true },
        signature = {
          enabled = false,
          auto_open = {
            enabled = false,
            trigger = true,
            luasnip = true,
          },
        },
        hover = {
          enabled = false,
          silent = false, -- warn if hover not available
        },
        message = { enabled = true },
      },
      cmdline = {
        enabled = true,
        view = "cmdline", -- "cmdline" | "cmdline_popup"
        format = {
          input = { view = "cmdline" },
        },
      },
      messages = {
        enabled = true, -- also automatically enables cmdline
      },
      popupmenu = {
        enabled = false,
        backend = "nui", -- "nui"|"cmp"
      },
      notify = {
        -- Noice can be used as `vim.notify` so you can route any notification like other messages
        -- Notification messages have their level and other properties set.
        -- event is always "notify" and kind can be any log level as a string
        -- The default routes will forward notifications to nvim-notify
        -- Benefit of using Noice for this is the routing and consistent history view
        enabled = true,
        view = "notify",
      },
    }

    map("n", "<leader>nl", ":NoiceLast<CR>", { silent = true, desc = "Notifications Last" })
    map("n", "<leader>nh", ":NoiceHistory<CR>", { silent = true, desc = "Notifications History" })
    map("n", "<leader>nn", ":NoiceAll<CR>", { silent = true, desc = "Notifications List" })
    map("n", "<leader>nd", ":NoiceDismiss<CR>", { silent = true, desc = "Notifications Dismiss All" })
    map("n", "<leader>np", ":NoicePick<CR>", { silent = true, desc = "Notifications Pick" })
    map("c", "<S-Enter>", function()
      noice.redirect(vim.fn.getcmdline())
    end, { desc = "Redirect Cmdline" })
    map({ "i", "n", "s" }, "<c-f>", function()
      if not noice.lsp.scroll(4) then
        return "<c-f>"
      end
    end, { silent = true, expr = true, desc = "Scroll Forward" })
    map({ "i", "n", "s" }, "<c-b>", function()
      if not noice.lsp.scroll(-4) then
        return "<c-b>"
      end
    end, { silent = true, expr = true, desc = "Scroll Backward" })
  end,
}
