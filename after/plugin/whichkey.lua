local mappings = vim.mappings
local wk = require("which-key")
local opts = {
key_labels = {
  -- General Keybindings
  ["<cr>"] = "Enter",
  ["<C-p>"] = "Ctrl+P",
  ["<Space>"] = "Space",
  ["<C-f>"] = "Ctrl+F",
  ["<C-t>"] = "Ctrl+T",
  ["<C-o>"] = "Ctrl+O",
  ["<C-d>"] = "Ctrl+D",
  ["<C-u>"] = "Ctrl+U",
  ["<C-y>"] = "Ctrl+Y",
  ["<C-n>"] = "Ctrl+N",
  ["<C-w>"] = "Ctrl+W",
  ["<C-a>"] = "Ctrl+A",
  ["<C-x>"] = "Ctrl+X",
  ["<C-e>"] = "Ctrl+E",
  ["<C-h>"] = "Ctrl+H",
  ["<C-j>"] = "Ctrl+J",
  ["<C-k>"] = "Ctrl+K",
  ["<C-l>"] = "Ctrl+L",
  ["<C-s>"] = "Ctrl+S",
  ["<C-v>"] = "Ctrl+V",
  ["<C-c>"] = "Ctrl+C",
  ["<C-b>"] = "Ctrl+B",
  ["<C-r>"] = "Ctrl+R",
  ["<C-z>"] = "Ctrl+Z",

  -- Special Characters
  ["_"] = "Underscore",
  ["$"] = "Dollar",
  ["{"] = "Curly Brace Open",
  ["}"] = "Curly Brace Close",
  ["<"] = "Less Than",
  [">"] = "Greater Than",

  -- Visual Mode Specific
  ["v"] = "Visual Mode",
  ["i"] = "Insert Mode",
  ["g"] = "Go",
  ["d"] = "Delete",
  ["r"] = "Replace",
  ["y"] = "Yank",
  ["t"] = "Till",
  ["f"] = "Find",
  ["a"] = "Append",
  ["A"] = "Append Line Start",

  -- HARPOON Specific
  ["1"] = "Harpoon 1",
  ["2"] = "Harpoon 2",
  ["3"] = "Harpoon 3",
  ["4"] = "Harpoon 4",
  ["5"] = "Harpoon 5",

  -- DAP Specific
  ["b"] = "Breakpoint",
  ["l"] = "Run Last",
  ["c"] = "Continue",
  ["u"] = "UI Toggle",

  -- Tmux Specific
  ["%"] = "Split Vertically",
  ["\""] = "Split Horizontally",
  ["o"] = "Rotate Panes",
  [";"] = "Toggle Pane",
  ["L"] = "Previous Pane",
  ["M"] = "Mouse Mode",
  [":"] = "Command Mode",
  [","] = "Rename Window",
  ["$"] = "Rename Session",
  ["&"] = "Kill Window",
  ["x"] = "Kill Pane",
  ["t"] = "Show Clock",
  ["["] = "Scroll Mode",
  ["]"] = "Paste Buffer",
  ["z"] = "Toggle Zoom",
  ["d"] = "Detach",
  ["q"] = "Show Pane Numbers",
  ["{"] = "Move Pane Left",
  ["}"] = "Move Pane Right",
  -- Leader (Space) Keybindings
  ["<leader>"] = "Leader (Space)",
  ["<leader>pf"] = "Leader pf - Git File Lookup",
  ["<leader>pv"] = "Leader pv - File Explorer",
  ["<leader>ps"] = "Leader ps - File Search",
  ["<leader>u"] = "Leader u - Undo Tree",
  ["<leader>gs"] = "Leader gs - Git Status",
  ["<leader>1"] = "Leader 1 - Harpoon Nav 1",
  ["<leader>2"] = "Leader 2 - Harpoon Nav 2",
  ["<leader>3"] = "Leader 3 - Harpoon Nav 3",
  ["<leader>4"] = "Leader 4 - Harpoon Nav 4",
  ["<leader>5"] = "Leader 5 - Run Current File",
  ["<leader>db"] = "Leader db - Toggle Breakpoint",
  ["<leader>dl"] = "Leader dl - Run Last",
  ["<leader>dc"] = "Leader dc - Continue",
  ["<leader>dui"] = "Leader dui - DAP UI Toggle",
}
}
wk.register(mappings, opts)
wk.setup(opts)
