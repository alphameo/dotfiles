return {
  "goolord/alpha-nvim",
  lazy = true,
  event = "VimEnter",
  config = function()
    -- local dashboard = require "alpha.themes.startify"
    local dashboard = require "alpha.themes.dashboard"
    dashboard.section.header.val = {
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
    }

    dashboard.section.buttons.val = {
      dashboard.button("n", "   New file", ":ene<CR>"),
      dashboard.button("f", "   Find file", ":Telescope find_files<CR>"),
      dashboard.button("r", "󱋡   Recent Files", ":Telescope oldfiles<CR>"),
      dashboard.button("L", "   Lazy", ":Lazy<CR>"),
      dashboard.button("M", "󰰐   Mason", ":Mason<CR>"),
      dashboard.button("s", "   Settings", ":e $MYVIMRC | :cd %:p:h | pwd<CR>"),
      dashboard.button("q", "󰅙   Quit NVIM", ":qa<CR>"),
    }

    require("alpha").setup(dashboard.opts)
  end,
}
