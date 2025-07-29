return {
  "folke/which-key.nvim",
  event = "VimEnter",
  config = function()
    local wk = require("which-key")
    
    -- Utility functions to replace snacks functionality
    local function delete_buffer()
      local bufnr = vim.api.nvim_get_current_buf()
      local alternate = vim.fn.bufnr("#")
      
      if alternate ~= bufnr and vim.api.nvim_buf_is_valid(alternate) then
        vim.api.nvim_set_current_buf(alternate)
      else
        vim.cmd("enew")
      end
      
      if vim.api.nvim_buf_is_valid(bufnr) then
        vim.api.nvim_buf_delete(bufnr, { force = false })
      end
    end

    local function create_scratch_buffer()
      vim.cmd("enew")
      vim.bo.buftype = "nofile"
      vim.bo.bufhidden = "hide"
      vim.bo.swapfile = false
    end

    local function rename_file()
      local old_name = vim.fn.expand("%:p")
      if old_name == "" then
        vim.notify("No file to rename", vim.log.levels.ERROR)
        return
      end
      
      local new_name = vim.fn.input("New name: ", old_name)
      if new_name == "" or new_name == old_name then
        return
      end
      
      vim.cmd("saveas " .. vim.fn.fnameescape(new_name))
      vim.fn.delete(old_name)
    end

    local function toggle_option(option, values)
      return function()
        if values then
          local current = vim.opt[option]:get()
          vim.opt[option] = current == values.on and values.off or values.on
        else
          vim.opt[option] = not vim.opt[option]:get()
        end
      end
    end

    local function toggle_diagnostics()
      local current = vim.diagnostic.is_disabled(0)
      if current then
        vim.diagnostic.enable(0)
        vim.notify("Diagnostics enabled")
      else
        vim.diagnostic.disable(0)
        vim.notify("Diagnostics disabled")
      end
    end

    local function toggle_inlay_hints()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end
    
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
      { "<C-/>", "<cmd>ToggleTerm<CR>", desc = "Toggle Terminal" },
      
      -- Movement
      { "]]", "*", desc = "Next Reference" },
      { "[[", "#", desc = "Prev Reference" },
      
      -- Go to mappings
      { "g", group = "Go to" },
      { "gd", function() require("fzf-lua").lsp_definitions() end, desc = "Go to Definition" },
      { "gD", function() require("fzf-lua").lsp_declarations() end, desc = "Go to Declaration" },
      { "gr", function() require("fzf-lua").lsp_references() end, desc = "Go to References" },
      { "gI", function() require("fzf-lua").lsp_implementations() end, desc = "Go to Implementation" },
      { "gy", function() require("fzf-lua").lsp_typedefs() end, desc = "Go to Type Definition" },
      
      -- Leader mappings
      { "<leader><space>", function() require("fzf-lua").files() end, desc = "Smart Find" },
      { "<leader>,", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>/", function() require("fzf-lua").live_grep() end, desc = "Grep" },
      { "<leader>:", function() require("fzf-lua").command_history() end, desc = "Command History" },
      { "<leader>e", "<cmd>Oil<CR>", desc = "File Explorer" },
      
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
      { "<leader>bd", delete_buffer, desc = "Delete Buffer" },
      
      -- Code actions
      { "<leader>c", group = "Code" },
      { "<leader>ca", vim.lsp.buf.code_action, desc = "Code Action" },
      { "<leader>cr", vim.lsp.buf.rename, desc = "Rename" },
      { "<leader>cR", rename_file, desc = "Rename File" },
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
      { "<leader>D", "<cmd>Lazydocker<cr>", desc = "LazyDocker" },
      
      -- File operations
      { "<leader>f", group = "Files" },
      { "<leader>fb", function() require("fzf-lua").buffers() end, desc = "Buffers" },
      { "<leader>fc", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end, desc = "Config Files" },
      { "<leader>ff", function() require("fzf-lua").files() end, desc = "Find Files" },
      { "<leader>fg", function() require("fzf-lua").git_files() end, desc = "Git Files" },
      { "<leader>fp", function() require("fzf-lua").files({ cwd = "~/Projects" }) end, desc = "Projects" },
      { "<leader>fr", function() require("fzf-lua").oldfiles() end, desc = "Recent Files" },
      
      -- Git
      { "<leader>g", group = "Git" },
      { "<leader>gb", function() require("fzf-lua").git_branches() end, desc = "Branches" },
      { "<leader>gB", function() vim.cmd("!gh browse") end, desc = "Git Browse" },
      { "<leader>gd", function() require("fzf-lua").git_status() end, desc = "Git Status" },
      { "<leader>gf", function() require("fzf-lua").git_bcommits() end, desc = "Git File History" },
      { "<leader>gg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
      { "<leader>gl", function() require("fzf-lua").git_commits() end, desc = "Git Log" },
      { "<leader>gL", function() require("fzf-lua").git_bcommits() end, desc = "Git Log File" },
      { "<leader>gs", function() require("fzf-lua").git_status() end, desc = "Git Status" },
      { "<leader>gS", function() require("fzf-lua").git_stash() end, desc = "Git Stash" },
      
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
      { "<leader>n", function() require("notify").dismiss({ silent = true, pending = true }) end, desc = "Dismiss Notifications" },
      { "<leader>N", function()
        local news_file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1]
        if news_file then
          vim.cmd("tabnew " .. news_file)
        end
      end, desc = "Neovim News" },
      
      -- Project/Find
      { "<leader>p", group = "Project/Find" },
      { "<leader>ps", function() require("fzf-lua").live_grep() end, desc = "Live Grep" },
      { "<leader>pr", function() require("fzf-lua").resume() end, desc = "Resume Last Search" },
      { "<leader>pg", function() require("fzf-lua").grep_last() end, desc = "Repeat Last Grep" },
      { "<leader>pv", "<cmd>Oil<CR>", desc = "File Explorer" },
      
      -- Search
      { "<leader>s", group = "Search" },
      { '<leader>s"', function() require("fzf-lua").registers() end, desc = "Registers" },
      { "<leader>s/", function() require("fzf-lua").search_history() end, desc = "Search History" },
      { "<leader>sa", function() require("fzf-lua").autocmds() end, desc = "Auto Commands" },
      { "<leader>sb", function() require("fzf-lua").blines() end, desc = "Buffer Lines" },
      { "<leader>sB", function() require("fzf-lua").grep({ search = "", fzf_opts = { ["--prompt"] = "Grep Buffers> " } }) end, desc = "Grep Buffers" },
      { "<leader>sc", function() require("fzf-lua").command_history() end, desc = "Command History" },
      { "<leader>sC", function() require("fzf-lua").commands() end, desc = "Commands" },
      { "<leader>sd", function() require("fzf-lua").diagnostics_document() end, desc = "Diagnostics" },
      { "<leader>sD", function() require("fzf-lua").diagnostics_workspace() end, desc = "Workspace Diagnostics" },
      { "<leader>sg", function() require("fzf-lua").live_grep() end, desc = "Grep" },
      { "<leader>sh", function() require("fzf-lua").help_tags() end, desc = "Help Pages" },
      { "<leader>sH", function() require("fzf-lua").highlights() end, desc = "Highlights" },
      { "<leader>si", function() require("fzf-lua").awesome_colorschemes() end, desc = "Icons" },
      { "<leader>sj", function() require("fzf-lua").jumps() end, desc = "Jumps" },
      { "<leader>sk", function() require("fzf-lua").keymaps() end, desc = "Keymaps" },
      { "<leader>sl", function() require("fzf-lua").loclist() end, desc = "Location List" },
      { "<leader>sm", function() require("fzf-lua").marks() end, desc = "Marks" },
      { "<leader>sM", function() require("fzf-lua").man_pages() end, desc = "Man Pages" },
      { "<leader>sp", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("data") .. "/lazy" }) end, desc = "Plugin Files" },
      { "<leader>sq", function() require("fzf-lua").quickfix() end, desc = "Quickfix List" },
      { "<leader>sR", function() require("fzf-lua").resume() end, desc = "Resume" },
      { "<leader>ss", function() require("fzf-lua").lsp_document_symbols() end, desc = "LSP Symbols" },
      { "<leader>sS", function() require("fzf-lua").lsp_workspace_symbols() end, desc = "LSP Workspace Symbols" },
      { "<leader>su", function() require("fzf-lua").changes() end, desc = "Undo History" },
      { "<leader>sw", function() require("fzf-lua").grep_cword() end, desc = "Word under Cursor" },
      
      -- UI/Toggles
      { "<leader>u", group = "UI/Toggles" },
      { "<leader>ub", toggle_option("background", { off = "light", on = "dark" }), desc = "Toggle Background" },
      { "<leader>uc", toggle_option("conceallevel", { off = 0, on = 2 }), desc = "Toggle Conceal" },
      { "<leader>uC", function() require("fzf-lua").colorschemes() end, desc = "Colorschemes" },
      { "<leader>ud", toggle_diagnostics, desc = "Toggle Diagnostics" },
      { "<leader>ug", "<cmd>IBLToggle<cr>", desc = "Toggle Indent Guides" },
      { "<leader>uh", toggle_inlay_hints, desc = "Toggle Inlay Hints" },
      { "<leader>ul", toggle_option("number"), desc = "Toggle Line Numbers" },
      { "<leader>uL", toggle_option("relativenumber"), desc = "Toggle Relative Numbers" },
      { "<leader>us", toggle_option("spell"), desc = "Toggle Spelling" },
      { "<leader>uT", "<cmd>TSToggle highlight<cr>", desc = "Toggle Treesitter" },
      { "<leader>uw", toggle_option("wrap"), desc = "Toggle Wrap" },
      
      -- Window/workspace
      { "<leader>w", group = "Window/Workspace" },
      { "<leader>wd", function() require("fzf-lua").lsp_document_symbols() end, desc = "Document Symbols" },
      
      -- Diagnostics & Delete operations
      { "<leader>x", group = "Diagnostics & Delete" },
      { "<leader>xq", vim.diagnostic.setloclist, desc = "Quickfix List" },
      { "<leader>xd", [["_d]], desc = "Delete to Void" },
      { "<leader>xp", [["_dP]], desc = "Paste without Overwrite" },
      
      -- Misc
      { "<leader>y", [["+y]], desc = "Yank to System" },
      { "<leader>Y", [["+Y]], desc = "Yank Line to System" },
      
      -- Zen/Focus
      { "<leader>z", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
      
      -- Scratch
      { "<leader>.", create_scratch_buffer, desc = "Toggle Scratch Buffer" },
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
      { "<leader>gB", function() vim.cmd("!gh browse") end, desc = "Git Browse" },
      { "<leader>s", group = "Search" },
      { "<leader>sw", function() require("fzf-lua").grep_visual() end, desc = "Search Selection" },
      { "<leader>x", group = "Delete" },
      { "<leader>xd", [["_d]], desc = "Delete to Void" },
      { "<leader>y", [["+y]], desc = "Yank to System" },
    })

    -- Terminal mode mappings
    wk.add({
      mode = { "t" },
      { "<Esc>", "<C-\\><C-n>", desc = "Exit Terminal Mode" },
      { "]]", "*", desc = "Next Reference" },
      { "[[", "#", desc = "Prev Reference" },
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