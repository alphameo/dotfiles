local map = vim.keymap.set
local opt = vim.opt

opt.wrap = true
opt.breakindent = true
opt.linebreak = true
opt.spelllang = {
  "en_US",
  "ru_RU",
}
opt.spell = true

map("n", "j", "gj", { silent = true })
map("n", "k", "gk", { silent = true })

map("n", "<leader>lp", ":MarkdownPreviewToggle<CR>", { silent = true, desc = "Markdown Preview" })
map("n", "<leader>lr", ":RenderMarkdown toggle<CR>", { silent = true, desc = "Markdown Render" })

map("n", "<leader>li", ":MoltenInit<CR>", { silent = true, desc = "Molten Initialize" })
map("n", "<leader>le", ":MoltenEvaluateOperator<CR>", { silent = true, desc = "Molten Operator Selection" })
map("n", "<leader>ll", ":MoltenEvaluateLine<CR>", { silent = true, desc = "Molten Evaluate Line" })
map("n", "<leader>lE", ":MoltenReevaluateCell<CR>", { silent = true, desc = "Molten Re-evaluate Cell" })
map("n", "<leader>ld", ":MoltenDelete<CR>", { silent = true, desc = "Molten Delete Cell" })
map("n", "<leader>lh", ":MoltenHideOutput<CR>", { silent = true, desc = "Molten Hide Output" })
map("n", "<leader>ls", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = "Molten Show/Enter Output" })
map("v", "<leader>lE", ":<C-u>MoltenEvaluateVisual<CR>gv", { silent = true, desc = "Evaluate visual selection" })

map("n", "<leader>lI", function()
  local venv = os.getenv "VIRTUAL_ENV" or os.getenv "CONDA_PREFIX"
  if venv ~= nil then
    -- in the form of /home/benlubas/.virtualenvs/VENV_NAME
    venv = string.match(venv, "/.+/(.+)")
    vim.cmd(("MoltenInit %s"):format(venv))
  else
    vim.cmd "MoltenInit python3"
  end
end, { desc = "Molten Initialize for python3", silent = true })

map("n", "<leader>lI", ":QuartoActivate<CR>", { silent = true, desc = "Quarto Initialize" })
map("n", "<leader>lP", ":QuartoPreview<CR>", { silent = true, desc = "Quarto Preview" })
local runner = require "quarto.runner"
map("n", "<leader>lc", runner.run_cell, { silent = true, desc = "Quarto Run Cell" })
map("n", "<leader>lu", runner.run_above, { silent = true, desc = "Quarto Run Cell And Upper" })
map("n", "<leader>la", runner.run_all, { silent = true, desc = "Quarto Run All Cells" })
map("n", "<leader>lL", runner.run_line, { silent = true, desc = "Quarto Run Line" })
map("n", "<leader>lA", function()
  runner.run_all(true)
end, { desc = "Quarto Run All Cells of All Languages", silent = true })
map("v", "<leader>lr", runner.run_range, { silent = true, desc = "Quarto Run Visual Range" })
