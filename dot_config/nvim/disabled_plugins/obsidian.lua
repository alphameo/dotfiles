local vault_path = vim.fn.expand "~" .. "/Notes"
return {
  "epwalsh/obsidian.nvim",
  version = "*",
  lazy = true,
  -- ft = "markdown",
  event = {
    "BufReadPre " .. vault_path .. "/*.md",
    "BufNewFile " .. vault_path .. "/*.md",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
    "hrsh7th/nvim-cmp", -- TODO: Remove when Blink-cmp released
  },
  config = function()
    require("obsidian").setup {
      workspaces = {
        {
          name = "personal",
          path = vault_path,
        },
      },

      disable_frontmatter = true,
      new_notes_location = "notes_subdir",

      note_id_func = function(title)
        local prefix = tostring(os.date("%Y-%m-%d", os.time()))
        if title ~= nil then
          title = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
        else
          title = os.time()
        end
        return prefix .. "-" .. title
      end,
      daily_notes = {
        folder = "diary",
        date_format = "%Y-%m-%d",
        template = "daily",
      },
      templates = {
        folder = "meta/templates",
      },
      ui = {
        enable = false,
      },
      picker = {
        name = "fzf-lua",
      },
      mappings = {
        ["gf"] = {
          action = function()
            return require("obsidian").util.gf_passthrough()
          end,
          opts = { noremap = false, expr = true, buffer = true, desc = "Go to link" },
        },
        ["<leader>cx"] = {
          action = function()
            return require("obsidian").util.toggle_checkbox()
          end,
          opts = { buffer = true, desc = "Code Checkbox Toggle" },
        },
        ["<leader>cA"] = {
          action = function()
            return require("obsidian").util.smart_action()
          end,
          opts = { buffer = true, expr = true, desc = "Code Smart Action" },
        },
      },
    }

    local map = vim.keymap.set
    map("n", "<leader>on", ":ObsidianFollowLink<CR>", { silent = true, desc = "Obsidian Follow Link" })
    map("n", "<leader>oN", ":ObsidianNew<CR>", { silent = true, desc = "Obsidian New" })
    map("n", "<leader>oo", ":ObsidianOpen<CR>", { silent = true, desc = "Obsidian Open" })
    map("n", "<leader>od", ":ObsidianDailies<CR>", { silent = true, desc = "Obsidian Dailies" })
    map("n", "<leader>orn", ":ObsidianRename<CR>", { silent = true, desc = "Obsidian Rename" })
    map("n", "<leader>oT", ":ObsidianTemplate<CR>", { silent = true, desc = "Obsidian Template" })
    map("n", "<leader>ob", ":ObsidianBacklinks<CR>", { silent = true, desc = "Obsidian Backlinks" })
    map("n", "<leader>ofg", ":ObsidianSearch<CR>", { silent = true, desc = "Obsidian Search" })
  end,
}
