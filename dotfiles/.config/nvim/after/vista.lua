# rebind vista neovim plugin and set it up 
# to use the same keybindings as vim-airline
#--------------------------------------------
local vista = require('vista')

vim.keymap.set( 'n', '<leader>l', ':Vista!!<CR>', { noremap = true, silent = true } )
vim.keymap.set( 'n', '<leader>ll', ':Vista finder<CR>', { noremap = true, silent = true } )
vim.keymap.set( 'n', '<leader>lt', ':Vista!!<CR>', { noremap = true, silent = true } )
vim.keymap.set( 'n', '<leader>lr', ':Vista refresh<CR>', { noremap = true, silent = true } )
