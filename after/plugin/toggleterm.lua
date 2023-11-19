require("toggleterm").setup()
--lvim.keys.normal_mode["<C-t>"] = "<cmd>ToggleTerm direction=float<cr>" --":ToggleTermToggleAll<CR>"
vim.api.nvim_set_keymap("n", "<C-t>", "<cmd>ToggleTerm direction=float<cr>", { noremap = true, silent = true })
vim.api.nvim_set_keymap('t', '<esc>', [[<C-\><C-n>]], {noremap = true, silent = true} )
