vim.g.mapleader = " "
--vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

vim.keymap.set("n", "<leader>pv", ":NvimTreeOpen<CR>")
-- this is for move commands, when highlighting we can move the corresponding lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")



vim.keymap.set("n", "J", "mzJ`z")

-- Allow half page jumpings to keep the cursor in the middle
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Allows search terms to keep cursor in the middle 
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("n", "<leader>vwm", function()
    require("vim-with-me").StartVimWithMe()
end)
vim.keymap.set("n", "<leader>svwm", function()
    require("vim-with-me").StopVimWithMe()
end)

-- greatest remap ever
-- Allow to copy paste and dont have the buffer reinitialized after pasting
vim.keymap.set("x", "<leader>p", [["_dP]])

-- next greatest remap ever : asbjornHaland
-- interactions with the system copy buffers
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

vim.keymap.set({"n", "v"}, "<leader>q", [["_d]])

-- This is going to get me cancelled
vim.keymap.set("i", "<C-c>", "<Esc>")

vim.keymap.set("n", "Q", "<nop>")
-- allo to jump between projects
vim.keymap.set("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Quick Fix Navigation
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Replace the work you are on
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])
-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>");
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>");

vim.keymap.set("n", "<leader><leader>", function()
    vim.cmd("so")
end)

-- Disable arrows movement
vim.keymap.set('', '<Up>', '<Nop>')
vim.keymap.set('', '<Down>', '<Nop>')
vim.keymap.set('', '<Left>', '<Nop>')
vim.keymap.set('', '<Right>', '<Nop>')


-- Debugger remaps
vim.keymap.set("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>")
vim.keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>")
vim.keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>")
vim.keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<CR>")
vim.keymap.set("n", "<leader>ds", "<cmd>lua require'dap'.step_over()<CR>")
vim.keymap.set("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>")
vim.keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<CR>")
vim.keymap.set("n", "<leader>du", "<cmd>lua require'dap'.up()<CR>")
vim.keymap.set("n", "<leader>dd", "<cmd>lua require'dap'.down()<CR>")
vim.keymap.set("n", "<leader>de", "<cmd>lua require'dap'.disconnect()<CR>")
vim.keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.close()<CR>")

-- Mapping for dap ui
vim.keymap.set("n", "<leader>dui", "<cmd>lua require'dapui'.toggle()<CR>")
vim.keymap.set("n", "<leader>duh", "<cmd>lua require'dapui'.hover()<CR>")
vim.opt.colorcolumn = "80"
vim.keymap.set("n", "<leader>duf", "<cmd>lua require'dapui'.float_element()<CR>")


-- Remaps for tmux vim plugin
vim.keymap.set("n", "<C-h>", "<cmd>lua require('tmux').move_left()<CR>")
vim.keymap.set("n", "<C-j>", "<cmd>lua require('tmux').move_bottom()<CR>")
vim.keymap.set("n", "<C-k>", "<cmd>lua require('tmux').move_top()<CR>")
vim.keymap.set("n", "<C-l>", "<cmd>lua require('tmux').move_right()<CR>")

-- Remap lazygit.nvim to <leader>gg
vim.keymap.set("n", "<leader>gg", "<cmd>lua require('lazygit').lazygit()<CR>")


