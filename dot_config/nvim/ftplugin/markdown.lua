local opt = vim.opt_local
opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spell = true
opt.conceallevel = 2

local map = vim.keymap.set
map("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { buffer = true, silent = true, desc = "Markdown Render" })
map("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { buffer = true, silent = true, desc = "Markdown Preview" })

map("n", "<leader>lm", ":MoltenInit<CR>", { buffer = true, silent = true, desc = "Molten Initialize" })
map(
  "n",
  "<leader>le",
  ":MoltenEvaluateOperator<CR>",
  { buffer = true, silent = true, desc = "Molten Operator Selection" }
)
map("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { buffer = true, silent = true, desc = "Molten Evaluate Line" })
map("n", "<leader>lE", ":MoltenReevaluateCell<CR>", { buffer = true, silent = true, desc = "Molten Re-evaluate Cell" })
map("n", "<leader>ld", ":MoltenDelete<CR>", { buffer = true, silent = true, desc = "Molten Delete Cell" })
map("n", "<leader>lh", ":MoltenHideOutput<CR>", { buffer = true, silent = true, desc = "Molten Hide Output" })
map(
  "n",
  "<leader>ls",
  ":noautocmd MoltenEnterOutput<CR>",
  { buffer = true, silent = true, desc = "Molten Show/Enter Output" }
)
map(
  "v",
  "<leader>lE",
  ":<C-u>MoltenEvaluateVisual<CR>gv",
  { buffer = true, silent = true, desc = "Evaluate visual selection" }
)
map("n", "<leader>lM", function()
  local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd "MoltenInit python3"
  end
end, { buffer = true, silent = true, desc = "Molten Initialize for python3" })

map("n", "<leader>lq", ":QuartoActivate<CR>", { buffer = true, silent = true, desc = "Quarto Initialize" })
map("n", "<leader>lP", ":QuartoPreview<CR>", { buffer = true, silent = true, desc = "Quarto Preview" })
map(
  "n",
  "<leader>lc",
  ":lua require('quarto.runner').run_cell()<CR>",
  { buffer = true, silent = true, desc = "Quarto Run Cell" }
)
map(
  "n",
  "<leader>lu",
  ":lua require('quarto.runner').run_above()<CR>",
  { buffer = true, silent = true, desc = "Quarto Run Cell And Upper" }
)
map(
  "n",
  "<leader>la",
  ":lua require('quarto.runner').run_all()<CR>",
  { buffer = true, silent = true, desc = "Quarto Run All Cells" }
)
map(
  "n",
  "<leader>lL",
  ":lua require('quarto.runner').run_line()<CR>",
  { buffer = true, silent = true, desc = "Quarto Run Line" }
)
map(
  "n",
  "<leader>lA",
  ":lua require('quarto.runner').run_all(true)<CR>",
  { buffer = true, silent = true, desc = "Quarto Run All Cells of All Languages" }
)
map(
  "v",
  "<leader>lr",
  ":lua require('quarto.runner').run_range()<CR>",
  { buffer = true, silent = true, desc = "Quarto Run Visual Range" }
)
