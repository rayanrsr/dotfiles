return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    
    wk.setup({
      preset = "modern",
      delay = 200,
      filter = function(mapping)
        -- example to exclude mappings without a description
        return mapping.desc and mapping.desc ~= ""
      end,
      spec = {}, -- will be populated below
      notify = true,
      triggers = {
        { "<auto>", mode = "nixsotc" },
        { "s", mode = { "n", "v" } },
      },
      win = {
        border = "rounded",
        padding = { 1, 2 },
        title = true,
        title_pos = "center",
        zindex = 1000,
        bo = {},
        wo = {
          winblend = 10,
        },
      },
      layout = {
        width = { min = 20 },
        spacing = 3,
      },
      keys = {
        scroll_down = "<c-d>",
        scroll_up = "<c-u>",
      },
      sort = { "local", "order", "group", "alphanum", "mod" },
      expand = 0,
      replace = {
        key = {
          function(key)
            return require("which-key.view").format(key)
          end,
        },
        desc = {
          { "<Plug>%(.*)%)", "%1" },
          { "^%+", "" },
          { "<[cC]md>", "" },
          { "<[cC][rR]>", "" },
          { "<[sS]ilent>", "" },
          { "^lua%s+", "" },
          { "^call%s+", "" },
          { "^:%s*", "" },
        },
      },
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
        ellipsis = "…",
        mappings = true,
        rules = {},
        colors = true,
        keys = {
          Up = " ",
          Down = " ",
          Left = " ",
          Right = " ",
          C = "󰘴 ",
          M = "󰘵 ",
          D = "󰘳 ",
          S = "󰘶 ",
          CR = "󰌑 ",
          Esc = "󱊷 ",
          ScrollWheelDown = "󱕐 ",
          ScrollWheelUp = "󱕑 ",
          NL = "󰌑 ",
          BS = "󰁮",
          Space = "󱁐 ",
          Tab = "󰌒 ",
          F1 = "󱊫",
          F2 = "󱊬",
          F3 = "󱊭",
          F4 = "󱊮",
          F5 = "󱊯",
          F6 = "󱊰",
          F7 = "󱊱",
          F8 = "󱊲",
          F9 = "󱊳",
          F10 = "󱊴",
          F11 = "󱊵",
          F12 = "󱊶",
        },
      },
      show_help = true,
      show_keys = true,
      disable = {
        bt = {},
        ft = {},
      },
    })

    -- Add all keybindings using the new v3 format
    wk.add({
      -- Global mappings
      { "<C-a>", function() require("harpoon"):list():add() end, desc = "Harpoon Add File" },
      { "<C-p>", function() require("fzf-lua").files() end, desc = "Find Files" },
      { "<C-e>", function() 
        local harpoon = require("harpoon")
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, desc = "Harpoon Quick Menu" },
      { "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", desc = "Tmux Sessionizer" },
      { "<C-n>", function() os.execute("tmux switch-client -t Notes || tmux new-session -s Notes") end, desc = "Notes Session" },
      { "<C-/>", function() require("snacks").terminal() end, desc = "Toggle Terminal" },
      
      -- Movement
      { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" },
      { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference" },
      
      -- Go to mappings
      { "g", group = "Go to" },
      { "gd", function() require("snacks").picker.lsp_definitions() end, desc = "Go to Definition" },
      { "gD", function() require("snacks").picker.lsp_declarations() end, desc = "Go to Declaration" },
      { "gr", function() require("snacks").picker.lsp_references() end, desc = "Go to References" },
      { "gI", function() require("snacks").picker.lsp_implementations() end, desc = "Go to Implementation" },
      { "gy", function() require("snacks").picker.lsp_type_definitions() end, desc = "Go to Type Definition" },
      
      -- Leader mappings
      { "<leader><space>", function() require("snacks").picker.smart() end, desc = "Smart Find" },
      { "<leader>,", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      { "<leader>/", function() require("snacks").picker.grep() end, desc = "Grep" },
      { "<leader>:", function() require("snacks").picker.command_history() end, desc = "Command History" },
      { "<leader>e", function() require("snacks").explorer() end, desc = "File Explorer" },
      
      -- Numbers for Harpoon
      { "<leader>1", function() require("harpoon"):list():select(1) end, desc = "Harpoon File 1" },
      { "<leader>2", function() require("harpoon"):list():select(2) end, desc = "Harpoon File 2" },
      { "<leader>3", function() require("harpoon"):list():select(3) end, desc = "Harpoon File 3" },
      { "<leader>4", function() require("harpoon"):list():select(4) end, desc = "Harpoon File 4" },
      { "<leader>5", function() require("harpoon"):list():select(5) end, desc = "Harpoon File 5" },
      
      -- AI/CodeCompanion
      { "<leader>a", group = "AI/CodeCompanion" },
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions" },
      { "<leader>ac", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat" },
      { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", desc = "Add to Chat" },
      
      -- Buffers
      { "<leader>b", group = "Buffers" },
      { "<leader>bd", function() require("snacks").bufdelete() end, desc = "Delete Buffer" },
      
      -- Code actions
      { "<leader>c", group = "Code" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>cR", function() require("snacks").rename.rename_file() end, desc = "Rename File" },
      { "<leader>cu", "<cmd>silent !cursor %<CR>", desc = "Open in Cursor" },
      
      -- Debug (DAP)
      { "<leader>d", group = "Debug" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dB", function() require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, desc = "Conditional Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dd", function() require("dap").disconnect() end, desc = "Disconnect" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate Expression" },
      { "<leader>dg", function() require("dap").session() end, desc = "Get Session" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>do", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>du", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dp", group = "Python Debug" },
      { "<leader>dpr", function() require("dap-python").test_method() end, desc = "Test Method" },
      { "<leader>dpc", function() require("dap-python").test_class() end, desc = "Test Class" },
      { "<leader>dps", function() require("dap-python").debug_selection() end, desc = "Debug Selection" },
      { "<leader>dP", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").continue() end, desc = "Start" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
      { "<leader>dU", function() require("dapui").toggle() end, desc = "Toggle DAP UI" },
      
             -- Docker 
       { "<leader>ld", "<cmd>Lazydocker<cr>", desc = "LazyDocker" },
      
      -- File operations
      { "<leader>f", group = "Files" },
      { "<leader>fb", function() require("snacks").picker.buffers() end, desc = "Buffers" },
      { "<leader>fc", function() require("snacks").picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files" },
      { "<leader>ff", function() require("snacks").picker.files() end, desc = "Find Files" },
      { "<leader>fg", function() require("snacks").picker.git_files() end, desc = "Git Files" },
      { "<leader>fp", function() require("snacks").picker.projects() end, desc = "Projects" },
      { "<leader>fr", function() require("snacks").picker.recent() end, desc = "Recent Files" },
      
      -- Git
      { "<leader>g", group = "Git" },
      { "<leader>gb", function() require("snacks").picker.git_branches() end, desc = "Branches" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse" },
      { "<leader>gd", function() require("snacks").picker.git_diff() end, desc = "Git Diff" },
      { "<leader>gf", function() require("snacks").picker.git_log_file() end, desc = "Git Log File" },
      { "<leader>gg", function() require("snacks").lazygit() end, desc = "LazyGit" },
      { "<leader>gl", function() require("snacks").picker.git_log() end, desc = "Git Log" },
      { "<leader>gL", function() require("snacks").picker.git_log_line() end, desc = "Git Log Line" },
      { "<leader>gs", function() require("snacks").picker.git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require("snacks").picker.git_stash() end, desc = "Git Stash" },
      
      -- LSP
      { "<leader>l", function() 
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
          vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
      end, desc = "Toggle LSP Lines" },
      
      -- Format
      { "<leader>m", group = "Format" },
      { "<leader>mp", function() require("conform").format({ async = true, lsp_format = "fallback" }) end, desc = "Format Buffer" },
      { "<leader>mP", function() require("conform").format({ formatters = { "ruff_organize_imports", "ruff_fix", "ruff_format" }, async = true }) end, desc = "Format Python" },
      
      -- Notifications
      { "<leader>n", function() require("snacks").notifier.show_history() end, desc = "Notification History" },
      { "<leader>N", function()
        require("snacks").win({
          file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
          width = 0.6,
          height = 0.6,
          wo = { spell = false, wrap = false, signcolumn = "yes", statuscolumn = " ", conceallevel = 3 },
        })
      end, desc = "Neovim News" },
      
      -- Project/Find
      { "<leader>p", group = "Project/Find" },
      { "<leader>ps", function() require("snacks").picker.grep() end, desc = "Live Grep" },
      { "<leader>pr", function() require("fzf-lua").resume() end, desc = "Resume Last Search" },
      { "<leader>pg", function() require("fzf-lua").grep_last() end, desc = "Repeat Last Grep" },
      { "<leader>pv", "<cmd>Oil<CR>", desc = "File Explorer" },
      
      -- Search
      { "<leader>s", group = "Search" },
      { '<leader>s"', function() require("snacks").picker.registers() end, desc = "Registers" },
      { "<leader>s/", function() require("snacks").picker.search_history() end, desc = "Search History" },
      { "<leader>sa", function() require("snacks").picker.autocmds() end, desc = "Auto Commands" },
      { "<leader>sb", function() require("snacks").picker.lines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() require("snacks").picker.grep_buffers() end, desc = "Grep Buffers" },
      { "<leader>sc", function() require("snacks").picker.command_history() end, desc = "Command History" },
      { "<leader>sC", function() require("snacks").picker.commands() end, desc = "Commands" },
      { "<leader>sd", function() require("snacks").picker.diagnostics() end, desc = "Diagnostics" },
      { "<leader>sD", function() require("snacks").picker.diagnostics_buffer() end, desc = "Buffer Diagnostics" },
      { "<leader>sg", function() require("snacks").picker.grep() end, desc = "Grep" },
      { "<leader>sh", function() require("snacks").picker.help() end, desc = "Help Pages" },
      { "<leader>sH", function() require("snacks").picker.highlights() end, desc = "Highlights" },
      { "<leader>si", function() require("snacks").picker.icons() end, desc = "Icons" },
      { "<leader>sj", function() require("snacks").picker.jumps() end, desc = "Jumps" },
      { "<leader>sk", function() require("snacks").picker.keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require("snacks").picker.loclist() end, desc = "Location List" },
      { "<leader>sm", function() require("snacks").picker.marks() end, desc = "Marks" },
      { "<leader>sM", function() require("snacks").picker.man() end, desc = "Man Pages" },
      { "<leader>sp", function() require("snacks").picker.lazy() end, desc = "Plugin Specs" },
      { "<leader>sq", function() require("snacks").picker.qflist() end, desc = "Quickfix List" },
      { "<leader>sR", function() require("snacks").picker.resume() end, desc = "Resume" },
      { "<leader>ss", function() require("snacks").picker.lsp_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require("snacks").picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "<leader>su", function() require("snacks").picker.undo() end, desc = "Undo History" },
      { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Word under Cursor" },
      
      -- UI/Toggles
      { "<leader>u", group = "UI/Toggles" },
      { "<leader>ub", function() require("snacks").toggle.option("background", { off = "light", on = "dark", name = "Dark Background" }) end, desc = "Toggle Background" },
      { "<leader>uc", function() require("snacks").toggle.option("conceallevel", { off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2 }) end, desc = "Toggle Conceal" },
      { "<leader>uC", function() require("snacks").picker.colorschemes() end, desc = "Colorschemes" },
      { "<leader>ud", function() require("snacks").toggle.diagnostics() end, desc = "Toggle Diagnostics" },
      { "<leader>uD", function() require("snacks").toggle.dim() end, desc = "Toggle Dim" },
      { "<leader>ug", function() require("snacks").toggle.indent() end, desc = "Toggle Indent Guides" },
      { "<leader>uh", function() require("snacks").toggle.inlay_hints() end, desc = "Toggle Inlay Hints" },
      { "<leader>ul", function() require("snacks").toggle.line_number() end, desc = "Toggle Line Numbers" },
      { "<leader>uL", function() require("snacks").toggle.option("relativenumber", { name = "Relative Number" }) end, desc = "Toggle Relative Numbers" },
      { "<leader>un", function() require("snacks").notifier.hide() end, desc = "Dismiss Notifications" },
      { "<leader>us", function() require("snacks").toggle.option("spell", { name = "Spelling" }) end, desc = "Toggle Spelling" },
      { "<leader>uT", function() require("snacks").toggle.treesitter() end, desc = "Toggle Treesitter" },
      { "<leader>uw", function() require("snacks").toggle.option("wrap", { name = "Wrap" }) end, desc = "Toggle Wrap" },
      
      -- Window/workspace
      { "<leader>w", group = "Window/Workspace" },
      { "<leader>wd", vim.lsp.buf.document_symbol, desc = "Document Symbols" },
      
             -- Diagnostics & Delete operations
       { "<leader>x", group = "Diagnostics & Delete" },
       { "<leader>xq", vim.diagnostic.setloclist, desc = "Quickfix List" },
       { "<leader>xd", [["_d]], desc = "Delete to Void" },
       { "<leader>xp", [["_dP]], desc = "Paste without Overwrite" },
       
       -- Misc
       { "<leader>y", [["+y]], desc = "Yank to System" },
       { "<leader>Y", [["+Y]], desc = "Yank Line to System" },
      
      -- Zen/Focus
      { "<leader>z", function() require("snacks").zen() end, desc = "Toggle Zen Mode" },
      { "<leader>Z", function() require("snacks").zen.zoom() end, desc = "Toggle Zoom" },
      
      -- Scratch
      { "<leader>.", function() require("snacks").scratch() end, desc = "Toggle Scratch Buffer" },
      { "<leader>S", function() require("snacks").scratch.select() end, desc = "Select Scratch Buffer" },
    })

    -- Visual mode mappings
    wk.add({
      mode = { "v" },
      { "<leader>a", group = "AI/CodeCompanion" },
      { "<leader>ad", "<cmd>CodeCompanionChat Add<cr>", desc = "Add Selection to Chat" },
      { "<leader>d", group = "Debug" },
      { "<leader>de", function() require("dapui").eval() end, desc = "Evaluate Expression" },
      { "<leader>dp", group = "Python Debug" },
      { "<leader>dps", function() require("dap-python").debug_selection() end, desc = "Debug Selection" },
      { "<leader>g", group = "Git" },
      { "<leader>gB", function() require("snacks").gitbrowse() end, desc = "Git Browse" },
             { "<leader>s", group = "Search" },
       { "<leader>sw", function() require("snacks").picker.grep_word() end, desc = "Search Selection" },
       { "<leader>x", group = "Delete" },
       { "<leader>xd", [["_d]], desc = "Delete to Void" },
       { "<leader>y", [["+y]], desc = "Yank to System" },
    })

    -- Terminal mode mappings
    wk.add({
      mode = { "t" },
      { "<Esc>", "<C-\\><C-n>", desc = "Exit Terminal Mode" },
      { "]]", function() require("snacks").words.jump(vim.v.count1) end, desc = "Next Reference" },
      { "[[", function() require("snacks").words.jump(-vim.v.count1) end, desc = "Prev Reference" },
    })

    -- Insert mode mappings
    wk.add({
      { "<C-c>", "<Esc>", desc = "Exit Insert Mode", mode = "i" },
    })

    -- Operator-pending mode mappings
    wk.add({
      mode = { "o" },
      { "s", function() require("flash").jump() end, desc = "Flash Jump" },
      { "S", function() require("flash").treesitter() end, desc = "Flash Treesitter" },
      { "r", function() require("flash").remote() end, desc = "Remote Flash" },
      { "R", function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    })

    -- Command mode mappings
    wk.add({
      { "<c-s>", function() require("flash").toggle() end, desc = "Toggle Flash Search", mode = "c" },
    })
  end,
} 