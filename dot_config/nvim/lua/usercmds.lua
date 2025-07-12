-- NOTE: TERMINALS
local win_state = {
  buf = -1,
  win = -1,
}

local toggle_terminal = function(create_win_func)
  if not vim.api.nvim_win_is_valid(win_state.win) or not vim.api.nvim_buf_is_valid(win_state.buf) then
    win_state = create_win_func { buf = win_state.buf }
    if vim.bo[win_state.buf].buftype ~= "terminal" then
      vim.api.nvim_call_function("termopen", { vim.o.shell })
    end
    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(win_state.win)
    vim.cmd "stopinsert"
  end
end

local new_hidden_win_state = function(opts, win_config)
  local buf
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
    vim.bo[buf].buflisted = false
    vim.bo[buf].swapfile = false
    vim.bo[buf].bufhidden = "hide"
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- NOTE: Terminal mappings
local map = vim.keymap.set
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<ESC><ESC>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })

-- NOTE: Split Terminal
local create_split_buffer = function(opts)
  opts = opts or {}

  local win_config = {
    vertical = false,
    split = "below",
    height = 15,
    style = "minimal",
  }

  return new_hidden_win_state(opts, win_config)
end

local toggle_split_terminal = function()
  toggle_terminal(create_split_buffer)
end

vim.api.nvim_create_user_command("ToggleSplitTerm", toggle_split_terminal, {})

map("n", "<leader>ts", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("n", "<C-`>", ":ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<leader>ts", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })
map("t", "<C-`>", "<C-\\><C-n>:ToggleSplitTerm<CR>", { silent = true, desc = "Terminal Split" })

-- NOTE: Float Terminal
local function create_floating_window(opts)
  opts = opts or {}
  local width = opts.width or math.floor(vim.o.columns * 0.8)
  local height = opts.height or math.floor(vim.o.lines * 0.8)

  local col = math.floor((vim.o.columns - width) / 2)
  local row = math.floor((vim.o.lines - height) / 2)

  local win_config = {
    relative = "editor",
    width = width,
    height = height,
    col = col,
    row = row,
    style = "minimal",
    border = "rounded",
  }

  return new_hidden_win_state(opts, win_config)
end

local toggle_float_terminal = function()
  toggle_terminal(create_floating_window)
end

vim.api.nvim_create_user_command("ToggleFloatTerm", toggle_float_terminal, {})

map("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("n", "<C-S-`>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
