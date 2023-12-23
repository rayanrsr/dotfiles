local mappings = vim.mappings
local wk = require("which-key")
local opts = {
key_labels = {


  -- Leader (Space) Keybindings
  -- ["<leader>"] = "Leader (Space)",
  -- ["<leader>pf"] = "Leader pf - Git File Lookup",
  -- ["<leader>pv"] = "Leader pv - File Explorer",
  -- ["<leader>ps"] = "Leader ps - File Search",
  -- ["<leader>u"] = "Leader u - Undo Tree",
  -- ["<leader>gs"] = "Leader gs - Git Status",
  -- ["<leader>1"] = "Leader 1 - Harpoon Nav 1",
  -- ["<leader>2"] = "Leader 2 - Harpoon Nav 2",
  -- ["<leader>3"] = "Leader 3 - Harpoon Nav 3",
  -- ["<leader>4"] = "Leader 4 - Harpoon Nav 4",
  -- ["<leader>5"] = "Leader 5 - Run Current File",
  -- ["<leader>db"] = "Leader db - Toggle Breakpoint",
  -- ["<leader>dl"] = "Leader dl - Run Last",
  -- ["<leader>dc"] = "Leader dc - Continue",
  -- ["<leader>dui"] = "Leader dui - DAP UI Toggle",
}
}
wk.register({

  ["<leader>pv"] = { "<cmd>NvimTreeOpen<CR>", "Open File Tree" },
  ["<leader>fn"] = { "<cmd>e ++enc=utf-8 | normal! Gc$", "New File" },
  ["<leader>ps"] = { "<cmd>Telescope live_grep<CR>", "Lookup File by Content" },

  ["<leader>J"] = { "<cmd>mzJ`z", "Join Lines" },
  ["<C-d>"] = { "<C-d>zz", "Half Page Down" },
  ["<C-u>"] = { "<C-u>zz", "Half Page Up" },
  ["<leader>vwm"] = { "<cmd>lua require('vim-with-me').StartVimWithMe()<CR>", "Start Vim With Me" },
  ["<leader>svwm"] = { "<cmd>lua require('vim-with-me').StopVimWithMe()<CR>", "Stop Vim With Me" },
  ["<leader>y"] = { [["+y]], "System Clipboard Yank" },
  ["<leader>Y"] = { [["+Y]], "System Clipboard Yank to End of Line" },
  ["<leader>q"] = { [["_d]], "Delete without Copying to System Clipboard" },
  ["<C-f>"] = { "<cmd>silent !tmux neww tmux-sessionizer<CR>", "Jump Between Projects" },
  ["<leader>f"] = { "<cmd>lua vim.lsp.buf.format()<CR>", "Format File" },
  -- ["<C-k>"] = { "<cmd>cnext<CR>zz", "Quick Fix Next" },
  -- ["<C-j>"] = { "<cmd>cprev<CR>zz", "Quick Fix Previous" },
   ["<leader>k"] = { "<cmd>lnext<CR>zz", "Location List Next" },
  ["<leader>j"] = { "<cmd>lprev<CR>zz", "Location List Previous" },
  ["<leader>s"] = { [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], "Search and Replace" },
  ["<leader>x"] = { "<cmd>!chmod +x %<CR>", "Make File Executable" },
  ["<leader>vpp"] = { "<cmd>e ~/.dotfiles/nvim/.config/nvim/lua/theprimeagen/packer.lua<CR>", "Edit Packer Config" },
  ["<leader>mr"] = { "<cmd>CellularAutomaton make_it_rain<CR>", "Make It Rain" },
  ["<leader><leader>"] = { "<cmd>so", "Reload Vim Config" },

  -- Debugger remaps
  ["<leader>d"] = { "Debugging", "Debugging" },
  ["<leader>db"] = { "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle Breakpoint" },

  ["<leader>dc"] = { "<cmd>lua require'dap'.continue()<CR>", "Continue Debugging" },
  ["<leader>dr"] = { "<cmd>lua require'dap'.repl.open()<CR>", "Open REPL" },
  ["<leader>dl"] = { "<cmd>lua require'dap'.run_last()<CR>", "Run Last Configuration" },
  ["<leader>ds"] = { "<cmd>lua require'dap'.step_over()<CR>", "Step Over" },
  ["<leader>di"] = { "<cmd>lua require'dap'.step_into()<CR>", "Step Into" },
  ["<leader>do"] = { "<cmd>lua require'dap'.step_out()<CR>", "Step Out" },
  ["<leader>du"] = { "<cmd>lua require'dap'.up()<CR>", "Navigate Up" },
  ["<leader>dd"] = { "<cmd>lua require'dap'.down()<CR>", "Navigate Down" },
  ["<leader>de"] = { "<cmd>lua require'dap'.disconnect()<CR>", "Disconnect Debugger" },
  ["<leader>dk"] = { "<cmd>lua require'dap'.close()<CR>", "Close Debugger" },

  -- Mapping for dap ui
  ["<leader>dui"] = { "<cmd>lua require'dapui'.toggle()<CR>", "Toggle DAP UI" },
  ["<leader>duh"] = { "<cmd>lua require'dapui'.hover()<CR>", "Show Hover UI" },
  ["<leader>duf"] = { "<cmd>lua require'dapui'.float_element()<CR>", "Float Element UI" },

  -- Remaps for tmux vim plugin
  ["<C-h>"] = { "<cmd>lua require('tmux').move_left()<CR>", "Tmux Move Left" },
 ["<C-j>"] = { "<cmd>lua require('tmux').move_bottom()<CR>", "Tmux Move Bottom" },
  ["<C-k>"] = { "<cmd>lua require('tmux').move_top()<CR>", "Tmux Move Top" },
  ["<C-l>"] = { "<cmd>lua require('tmux').move_right()<CR>", "Tmux Move Right" },

  -- Remap lazygit.nvim to <leader>gg
  ["<leader>gg"] = { "<cmd>lua require('lazygit').lazygit()<CR>", "Open LazyGit" },
  
  
  ['[d'] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
  [']d'] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic" },
  ["<leader>vd"] = { "<cmd>lua vim.diagnostic.open_float(0, { scope = 'line' })<CR>", "Diagnostic Details" },
  ["<leader>vca"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
  ["<leader>vrr"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
  ["<leader>vrn"] = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename" },
  ["<leader>vws"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace Symbols" },
  ["gd"] = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
  ["K"] = { "<cmd>lua vim.lsp.buf.hover()<CR>", "Hover" },
  ["<C-h>"] = { "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
  ["<leader>g0"] = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  ["<leader>gW"] = { "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", "Workspace Symbols" },
  ["<leader>gA"] = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code Action" },
  ["<leader>gR"] = { "<cmd>lua vim.lsp.buf.references()<CR>", "References" },
  ["<leader>gF"] = { "<cmd>lua vim.lsp.buf.formatting()<CR>", "Format" },
  ["<leader>gS"] = { "<cmd>lua vim.lsp.buf.document_symbol()<CR>", "Document Symbols" },
  ["<leader>gD"] = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Declaration" },
  ["<leader>gI"] = { "<cmd>lua vim
  
})
wk.setup(opts)
