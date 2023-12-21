vim.opt.guicursor = ""

vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true
-- disable netrw at the very start of your init.lua
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true


vim.opt.scrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50


local ag = vim.api.nvim_create_augroup
local au = vim.api.nvim_create_autocmd

---Highlight yanked text
--
au('TextYankPost', {
  group = ag('yank_highlight', {}),
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup='IncSearch', timeout=300 }
  end,
})

-- Set clipboard to unnamed
vim.api.nvim_set_option("clipboard","unnamed")

-- Set colorcolumn
vim.api.nvim_set_option("colorcolumn","120")

-- Set cursorline
