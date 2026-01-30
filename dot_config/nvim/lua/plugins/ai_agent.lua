return {
  "greggh/claude-code.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim", -- Required for git operations
  },
  opts = {
    -- Terminal window settings
    window = {
      split_ratio = 0.3, -- Percentage of screen for the terminal window
      position = "botright", -- Position: "botright", "topleft", "vertical", "float"
      enter_insert = true, -- Enter insert mode when opening Claude Code
      hide_numbers = true, -- Hide line numbers in terminal window
      hide_signcolumn = true, -- Hide sign column in terminal window

      -- Floating window configuration (only applies when position = "float")
      float = {
        width = "80%",
        height = "80%",
        row = "center",
        col = "center",
        relative = "editor",
        border = "rounded",
      },
    },
    -- File refresh settings
    refresh = {
      enable = true, -- Enable file change detection
      updatetime = 100, -- updatetime when Claude Code is active (milliseconds)
      timer_interval = 1000, -- How often to check for file changes (milliseconds)
      show_notifications = true, -- Show notification when files are reloaded
    },
    -- Git project settings
    git = {
      use_git_root = true, -- Set CWD to git root when opening Claude Code
    },
    -- Command settings
    command = "claude",
    -- Command variants
    command_variants = {
      continue = "--continue", -- Resume the most recent conversation
      resume = "--resume", -- Display interactive conversation picker
      verbose = "--verbose", -- Enable verbose logging
    },
    -- Keymaps
    keymaps = {
      toggle = {
        normal = "<leader>cn", -- Normal mode keymap for toggling
        terminal = "<leader>ct", -- Terminal mode keymap for toggling
        variants = {
          continue = "<leader>cC", -- Continue conversation
          verbose = "<leader>cV", -- Verbose mode
        },
      },
      window_navigation = true, -- Enable <C-h/j/k/l> navigation
      scrolling = true, -- Enable <C-f/b> scrolling
    },
  },
}
