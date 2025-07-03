return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Global options
    winopts = {
      height = 0.85,
      width = 0.80,
      preview = {
        default = "bat",
        border = "border",
        wrap = "nowrap",
        hidden = "nohidden",
        vertical = "down:45%",
        horizontal = "right:50%",
        layout = "flex",
        flip_columns = 120,
      },
    },
    keymap = {
      builtin = {
        ["<F1>"] = "toggle-help",
        ["<F2>"] = "toggle-fullscreen",
        ["<F3>"] = "toggle-preview-wrap",
        ["<F4>"] = "toggle-preview",
        ["<F5>"] = "toggle-preview-ccw",
        ["<F6>"] = "toggle-preview-cw",
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
        ["<S-left>"] = "preview-page-reset",
      },
      fzf = {
        ["ctrl-z"] = "abort",
        ["ctrl-u"] = "unix-line-discard",
        ["ctrl-f"] = "half-page-down",
        ["ctrl-b"] = "half-page-up",
        ["ctrl-a"] = "beginning-of-line",
        ["ctrl-e"] = "end-of-line",
        ["alt-a"] = "toggle-all",
        ["f3"] = "toggle-preview-wrap",
        ["f4"] = "toggle-preview",
        ["shift-down"] = "preview-page-down",
        ["shift-up"] = "preview-page-up",
      },
    },
    actions = {
      files = {
        ["default"] = require("fzf-lua.actions").file_edit_or_qf,
        ["ctrl-s"] = require("fzf-lua.actions").file_split,
        ["ctrl-v"] = require("fzf-lua.actions").file_vsplit,
        ["ctrl-t"] = require("fzf-lua.actions").file_tabedit,
        ["alt-q"] = require("fzf-lua.actions").file_sel_to_qf,
        ["alt-l"] = require("fzf-lua.actions").file_sel_to_ll,
      },
      buffers = {
        ["default"] = require("fzf-lua.actions").buf_edit,
        ["ctrl-s"] = require("fzf-lua.actions").buf_split,
        ["ctrl-v"] = require("fzf-lua.actions").buf_vsplit,
        ["ctrl-t"] = require("fzf-lua.actions").buf_tabedit,
      },
    },
    fzf_opts = {
      ["--ansi"] = "",
      ["--info"] = "inline",
      ["--height"] = "100%",
      ["--layout"] = "reverse",
      ["--border"] = "none",
    },
    -- Specific picker options
    files = {
      prompt = "Files❯ ",
      multiprocess = true,
      file_icons = true,
      color_icons = true,
      git_icons = true,
      cmd = "find . -type f -printf '%P\n' 2>/dev/null | head -200000",
      find_opts = [[-type f -not -path '*/\.git/*' -printf '%P\n']],
      rg_opts = "--color=never --files --hidden --follow -g '!.git'",
      fd_opts = "--color=never --type f --hidden --follow --exclude .git",
    },
    grep = {
      prompt = "Rg❯ ",
      input_prompt = "Grep For❯ ",
      multiprocess = true,
      file_icons = true,
      color_icons = true,
      git_icons = true,
      rg_opts = "--column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e",
      grep_opts = "--binary-files=without-match --line-number --recursive --color=auto --perl-regexp -e",
    },
    buffers = {
      prompt = "Buffers❯ ",
      file_icons = true,
      color_icons = true,
      sort_lastused = true,
      ignore_current_buffer = false,
    },
    git = {
      files = {
        prompt = "GitFiles❯ ",
        cmd = "git ls-files --exclude-standard",
        multiprocess = true,
        file_icons = true,
        color_icons = true,
        git_icons = true,
      },
      status = {
        prompt = "GitStatus❯ ",
        cmd = "git -c color.status=false status --porcelain=v1",
        file_icons = true,
        color_icons = true,
        git_icons = true,
      },
      commits = {
        prompt = "Commits❯ ",
        cmd = "git log --color=always --pretty=format:'%C(yellow)%h%C(red)%d%C(reset) - %C(bold green)(%cr)%C(reset) %s %C(blue)<%an>%C(reset)' --abbrev-commit",
        file_icons = true,
        color_icons = true,
      },
      branches = {
        prompt = "Branches❯ ",
        cmd = "git branch --all --color=always",
        file_icons = true,
        color_icons = true,
      },
    },
    lsp = {
      prompt_postfix = "❯ ",
      file_icons = true,
      color_icons = true,
      git_icons = true,
      symbols = {
        symbol_style = 1,
        symbol_hl_prefix = "CmpItemKind",
        symbol_fmt = function(s) return "[" .. s .. "]" end,
      },
    },
    diagnostics = {
      prompt = "Diagnostics❯ ",
      file_icons = true,
      color_icons = true,
      git_icons = true,
      diag_icons = true,
    },
  },
  keys = {
    -- Core pickers
    {
      "<leader>gx",
      function()
        require("fzf-lua").git_branches()
      end,
      desc = "Git Branches",
    },
    {
      "<leader>,",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>/",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>:",
      function()
        require("fzf-lua").command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader><space>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find Files",
    },
    
    -- Find
    {
      "<leader>fb",
      function()
        require("fzf-lua").buffers()
      end,
      desc = "Buffers",
    },
    {
      "<leader>pv",
      function()
        require("fzf-lua").files()
      end,
      desc = "File Explorer",
    },
    {
      "<leader>fc",
      function()
        require("fzf-lua").files({ cwd = vim.fn.stdpath("config") })
      end,
      desc = "Find Config Files",
    },
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find Files",
    },
    {
      "<leader>fg",
      function()
        require("fzf-lua").git_files()
      end,
      desc = "Git Files",
    },
    {
      "<leader>fr",
      function()
        require("fzf-lua").oldfiles()
      end,
      desc = "Recent Files",
    },
    
    -- Git
    {
      "<leader>gc",
      function()
        require("fzf-lua").git_commits()
      end,
      desc = "Git Commits",
    },
    {
      "<leader>gs",
      function()
        require("fzf-lua").git_status()
      end,
      desc = "Git Status",
    },
    
    -- Search
    {
      "<leader>sb",
      function()
        require("fzf-lua").blines()
      end,
      desc = "Buffer Lines",
    },
    {
      "<leader>sB",
      function()
        require("fzf-lua").lines()
      end,
      desc = "Lines in Open Buffers",
    },
    {
      "<leader>ps",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live Grep",
    },
    {
      "<leader>sw",
      function()
        require("fzf-lua").grep_cword()
      end,
      desc = "Grep Word Under Cursor",
      mode = "n",
    },
    {
      "<leader>sw",
      function()
        require("fzf-lua").grep_visual()
      end,
      desc = "Grep Visual Selection",
      mode = "v",
    },
    {
      '<leader>s"',
      function()
        require("fzf-lua").registers()
      end,
      desc = "Registers",
    },
    {
      "<leader>sa",
      function()
        require("fzf-lua").autocmds()
      end,
      desc = "Autocmds",
    },
    {
      "<leader>sc",
      function()
        require("fzf-lua").command_history()
      end,
      desc = "Command History",
    },
    {
      "<leader>sC",
      function()
        require("fzf-lua").commands()
      end,
      desc = "Commands",
    },
    {
      "<leader>sd",
      function()
        require("fzf-lua").diagnostics_document()
      end,
      desc = "Document Diagnostics",
    },
    {
      "<leader>sD",
      function()
        require("fzf-lua").diagnostics_workspace()
      end,
      desc = "Workspace Diagnostics",
    },
    {
      "<leader>sh",
      function()
        require("fzf-lua").help_tags()
      end,
      desc = "Help Tags",
    },
    {
      "<leader>sH",
      function()
        require("fzf-lua").highlights()
      end,
      desc = "Highlights",
    },
    {
      "<leader>sj",
      function()
        require("fzf-lua").jumps()
      end,
      desc = "Jumps",
    },
    {
      "<leader>sk",
      function()
        require("fzf-lua").keymaps()
      end,
      desc = "Keymaps",
    },
    {
      "<leader>sl",
      function()
        require("fzf-lua").loclist()
      end,
      desc = "Location List",
    },
    {
      "<leader>sM",
      function()
        require("fzf-lua").manpages()
      end,
      desc = "Man Pages",
    },
    {
      "<leader>sm",
      function()
        require("fzf-lua").marks()
      end,
      desc = "Marks",
    },
    {
      "<leader>sR",
      function()
        require("fzf-lua").resume()
      end,
      desc = "Resume Last Picker",
    },
    {
      "<leader>sq",
      function()
        require("fzf-lua").quickfix()
      end,
      desc = "Quickfix List",
    },
    {
      "<leader>uC",
      function()
        require("fzf-lua").colorschemes()
      end,
      desc = "Colorschemes",
    },
    {
      "<leader>qp",
      function()
        require("fzf-lua").files({ cwd = "~" })
      end,
      desc = "Projects",
    },
    
    -- LSP
    {
      "gd",
      function()
        require("fzf-lua").lsp_definitions()
      end,
      desc = "LSP Definitions",
    },
    {
      "gr",
      function()
        require("fzf-lua").lsp_references()
      end,
      desc = "LSP References",
    },
    {
      "gI",
      function()
        require("fzf-lua").lsp_implementations()
      end,
      desc = "LSP Implementations",
    },
    {
      "gy",
      function()
        require("fzf-lua").lsp_typedefs()
      end,
      desc = "LSP Type Definitions",
    },
    {
      "<leader>ss",
      function()
        require("fzf-lua").lsp_document_symbols()
      end,
      desc = "LSP Document Symbols",
    },
    {
      "<leader>sS",
      function()
        require("fzf-lua").lsp_workspace_symbols()
      end,
      desc = "LSP Workspace Symbols",
    },
  },
} 