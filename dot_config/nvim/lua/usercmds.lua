-- NOTE: TERMINALS
local terminal_state = {
  buf = -1,
  win = -1,
}

local toggle_terminal = function(create_win_func)
  if not vim.api.nvim_win_is_valid(terminal_state.win) then
    terminal_state = create_win_func { buf = terminal_state.buf }
    if vim.bo[terminal_state.buf].buftype ~= "terminal" then
      vim.cmd.terminal()
    end
    vim.cmd "startinsert"
  else
    vim.api.nvim_win_hide(terminal_state.win)
    vim.cmd "stopinsert"
  end
end

local new_term_state = function(opts, win_config)
  local buf = nil
  if vim.api.nvim_buf_is_valid(opts.buf) then
    buf = opts.buf
  else
    buf = vim.api.nvim_create_buf(false, true)
  end

  local win = vim.api.nvim_open_win(buf, true, win_config)

  return { buf = buf, win = win }
end

-- NOTE: Terminal mappings
local map = vim.keymap.set
map("n", "<leader>tt", ":terminal<CR>", { silent = true, desc = "Terminal Tab New" })
map("t", "<C-q>", "<C-\\><C-n>", { silent = true, remap = true, desc = "Exit Terminal Mode" })
map("t", "<A-t>", "<C-\\><C-n><A-t>", { silent = true, remap = true, desc = "Term: Tab New" })
map("t", "<A-w>", "<C-\\><C-n><A-w>", { silent = true, remap = true, desc = "Term: Tab Quit" })
map("t", "<C-]>", "<C-\\><C-n><C-]>", { silent = true, remap = true, desc = "Term: Next Tab (buffer)" })
map("t", "<C-[>", "<C-\\><C-n><C-[>", { silent = true, remap = true, desc = "Term: Previous Tab (buffer)" })
map("t", "<C-0>", "<C-\\><C-n><C-0>", { silent = true, remap = true, desc = "Term: Move Tab (buffer) Right" })
map("t", "<C-9>", "<C-\\><C-n><C-9>", { silent = true, remap = true, desc = "Term: Move Tab (buffer) Next" })
map("t", "<C-g>", "<C-\\><C-n><C-g>", { silent = true, remap = true, desc = "Term: Pick Tab (buffer) Next" })
map("t", "<A-s>", "<C-\\><C-n><A-s>", { silent = true, remap = true, desc = "Term: Window Horizontal Split" })
map("t", "<A-v>", "<C-\\><C-n><A-v>", { silent = true, remap = true, desc = "Term: Window Vertical Split" })
map("t", "<A-q>", "<C-\\><C-n><A-q>", { silent = true, remap = true, desc = "Term: Window Quit" })
map("t", "<C-k>", "<C-\\><C-n><C-k>", { silent = true, remap = true, desc = "Term: Go to Upper window" })
map("t", "<C-j>", "<C-\\><C-n><C-j>", { silent = true, remap = true, desc = "Term: Go to Lower window" })
map("t", "<C-h>", "<C-\\><C-n><C-h>", { silent = true, remap = true, desc = "Term: Go to Left window" })
map("t", "<C-l>", "<C-\\><C-n><C-l>", { silent = true, remap = true, desc = "Term: Go to Right window" })
map("t", "<C-=>", "<C-\\><C-n><C-=>", { silent = true, remap = true, desc = "Term: Window Taller" })
map("t", "<C-->", "<C-\\><C-n><C-->", { silent = true, remap = true, desc = "Term: Window Shorter" })
map("t", "<C-.>", "<C-\\><C-n><C-.>", { silent = true, remap = true, desc = "Term: Window Wider" })
map("t", "<C-,>", "<C-\\><C-n><C-,>", { silent = true, remap = true, desc = "Term: Window Narrower" })

-- NOTE: Split Terminal
local create_split_buffer = function(opts)
  opts = opts or {}

  local win_config = {
    vertical = false,
    split = "below",
    height = 15,
    style = "minimal",
  }

  return new_term_state(opts, win_config)
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

  return new_term_state(opts, win_config)
end

local toggle_float_terminal = function()
  toggle_terminal(create_floating_window)
end

vim.api.nvim_create_user_command("ToggleFloatTerm", toggle_float_terminal, {})

map("n", "<leader>tf", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("n", "<C-S-`>", ":ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<leader>tf", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
map("t", "<C-S-`>", "<C-\\><C-n>:ToggleFloatTerm<CR>", { silent = true, desc = "Terminal Floating" })
