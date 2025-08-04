vim.api.nvim_create_autocmd("User", {
  pattern = "MiniStarterOpened",
  callback = function()
    vim.keymap.set(
      "n",
      "<leader>e",
      ":Neotree focus left toggle<CR>",
      { buffer = true, silent = true, desc = "File Explorer" }
    )
  end,
})
return {
  "echasnovski/mini.starter",
  version = false,
  lazy = true,
  event = "VimEnter",
  config = function()
    local header = table.concat({
      [[                                                     ]],
      [[  ███▄    █ ▓█████  ▒█████   ██▒   █▓ ██▓ ███▄ ▄███▓ ]],
      [[  ██ ▀█   █ ▓█   ▀ ▒██▒  ██▒▓██░   █▒▓██▒▓██▒▀█▀ ██▒ ]],
      [[ ▓██  ▀█ ██▒▒███   ▒██░  ██▒ ▓██  █▒░▒██▒▓██    ▓██░ ]],
      [[ ▓██▒  ▐▌██▒▒▓█  ▄ ▒██   ██░  ▒██ █░░░██░▒██    ▒██  ]],
      [[ ▒██░   ▓██░░▒████▒░ ████▓▒░   ▒▀█░  ░██░▒██▒   ░██▒ ]],
      [[ ░ ▒░   ▒ ▒ ░░ ▒░ ░░ ▒░▒░▒░    ░ ▐░  ░▓  ░ ▒░   ░  ░ ]],
      [[ ░ ░░   ░ ▒░ ░ ░  ░  ░ ▒ ▒░    ░ ░░   ▒ ░░  ░      ░ ]],
      [[    ░   ░ ░    ░   ░ ░ ░ ▒       ░░   ▒ ░░      ░    ]],
      [[          ░    ░  ░    ░ ░        ░   ░         ░    ]],
      [[                                 ░                   ]],
      [[                                                     ]],
    }, "\n")
    local pad = string.rep(" ", 18)
    local section_name = ""
    local starter = require "mini.starter"
    starter.setup {
      autoopen = true,
      evaluate_single = true,
      header = header,
      items = {
        { name = "n    New file", action = "ene", section = section_name },
        { name = "f    Find file", action = "Telescope find_files", section = section_name },
        { name = "r 󱋡   Recent Files", action = "Telescope oldfiles", section = section_name },
        { name = "w    Workspaces", action = "lua require('mini.sessions').select('read')", section = section_name },
        { name = "L    Lazy", action = "Lazy", section = section_name },
        { name = "M 󰰐   Mason", action = "Mason", section = section_name },
        { name = "S    Settings", action = "e $MYVIMRC | :cd %:p:h | pwd", section = section_name },
        { name = "q 󰅙   Quit NVIM", action = "qa", section = section_name },
      },
      footer = "",
      content_hooks = {
        starter.gen_hook.adding_bullet(pad, false),
        starter.gen_hook.aligning("center", "center"),
      },
    }
  end,
}
