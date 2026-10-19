-- Git branch function with caching and Nerd Font icon
local cached_branch = ""
local last_check = 0
local function git_branch()
  local now = vim.loop.now()
  if now - last_check > 5000 then -- Check every 5 seconds
    cached_branch = vim.fn.system "git branch --show-current 2>/dev/null | tr -d '\n'"
    last_check = now
  end
  if cached_branch ~= "" then
    return " \u{e725} " .. cached_branch .. " " -- nf-dev-git_branch
  end
  return ""
end

-- File type with Nerd Font icon
local function file_type()
  local ft = vim.bo.filetype
  local icons = {
    lua = " ", -- nf-dev-lua
    python = " ", -- nf-dev-python
    javascript = " ", -- nf-dev-javascript
    typescript = " ", -- nf-dev-typescript
    javascriptreact = " ",
    typescriptreact = " ",
    html = " ", -- nf-dev-html5
    css = " ", -- nf-dev-css3
    scss = " ",
    json = " ", -- nf-dev-json
    markdown = " ", -- nf-dev-markdown
    vim = " ", -- nf-dev-vim
    sh = " ", -- nf-oct-terminal
    bash = "  ",
    zsh = "  ",
    rust = " ", -- nf-dev-rust
    go = " ", -- nf-dev-go
    c = " ", -- nf-dev-c
    cpp = " ", -- nf-dev-cplusplus
    java = " ", -- nf-dev-java
    php = " ", -- nf-dev-php
    ruby = " ", -- nf-dev-ruby
    swift = " ", -- nf-dev-swift
    kotlin = " ",
    dart = " ",
    elixir = " ",
    haskell = " ",
    sql = " ",
    yaml = " ",
    toml = " ",
    xml = "󰗀 ",
    dockerfile = " ", -- nf-linux-docker
    gitcommit = " ", -- nf-oct-git_commit
    gitconfig = " ", -- nf-fa-git
    vue = " ", -- nf-md-vuejs
    svelte = " ",
    astro = " ",
  }

  if ft == "" then
    return "  " -- nf-fa-file_o
  end

  return ((icons[ft] or "  ") .. ft)
end

-- File size with Nerd Font icon
local function file_size()
  local size = vim.fn.getfsize(vim.fn.expand "%")
  if size < 0 then
    return ""
  end
  local size_str
  if size < 1024 then
    size_str = size .. "B"
  elseif size < 1024 * 1024 then
    size_str = string.format("%.1fK", size / 1024)
  else
    size_str = string.format("%.1fM", size / 1024 / 1024)
  end
  return "  " .. size_str .. " " -- nf-fa-file_o
end

-- Mode indicators with Nerd Font icons
local function mode_icon()
  local mode = vim.fn.mode()
  local modes = {
    n = "   NORMAL",
    i = "   INSERT",
    v = " 󰅨 VISUAL",
    V = " 󰅨 V-LINE",
    ["\22"] = " 󰅨 V-BLOCK",
    c = "   COMMAND",
    s = "  SELECT",
    S = "  S-LINE",
    ["\19"] = "  S-BLOCK",
    R = "  REPLACE",
    r = "  REPLACE",
    ["!"] = "  SHELL",
    t = "  TERMINAL",
  }
  return modes[mode] or ("  " .. mode)
end

_G.mode_icon = mode_icon
_G.git_branch = git_branch
_G.file_type = file_type
_G.file_size = file_size

vim.cmd [[
  highlight StatusLineBold gui=bold cterm=bold
]]

-- Function to change statusline based on window focus
local function setup_dynamic_statusline()
  vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter" }, {
    callback = function()
      vim.opt_local.statusline = table.concat {
        "  ",
        "%#StatusLineBold#",
        "%{v:lua.mode_icon()}",
        "%#StatusLine#",
        "  %f %h%m%r", -- nf-pl-left_hard_divider
        "%{v:lua.git_branch()}",
        " ", -- nf-pl-left_hard_divider
        "%{v:lua.file_type()}",
        " ", -- nf-pl-left_hard_divider
        "%{v:lua.file_size()}",
        "%=", -- Right-align everything after this
        "  %l:%c  %P ", -- nf-fa-clock_o for line/col
      }
    end,
  })
  vim.api.nvim_set_hl(0, "StatusLineBold", { bold = true })

  vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave" }, {
    callback = function()
      vim.opt_local.statusline = "  %f %h%m%r  %{v:lua.file_type()} %=  %l:%c   %P "
    end,
  })
end

setup_dynamic_statusline()
