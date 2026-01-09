return {
  {
    "olimorris/codecompanion.nvim",
    version = "^18.0.0",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    -- NOTE: Newer CodeCompanion versions use `interactions`; older versions used `strategies`.
    -- We set both for resilience across minor version changes.
    opts = {
      interactions = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.0-flash",
          },
        },
        inline = {
          adapter = {
            name = "gemini",
            model = "gemini-2.0-flash",
          },
        },
        cmd = {
          adapter = {
            name = "gemini",
            model = "gemini-2.0-flash",
          },
        },
      },
      strategies = {
        chat = { adapter = "gemini" },
        inline = { adapter = "gemini" },
        cmd = { adapter = "gemini" },
      },
      opts = {
        log_level = "INFO",
      },
    },
    config = function(_, opts)
      require("codecompanion").setup(opts)
    end,
    init = function()
      -- Expand 'cc' into 'CodeCompanion' in the command line
      vim.cmd([[cabbrev cc CodeCompanion]])
    end,
    keys = {
      -- Docs suggest <C-a>, but it's already used by Harpoon in this config.
      { "<leader>aa", "<cmd>CodeCompanionActions<cr>", desc = "CodeCompanion Actions", mode = { "n", "v" } },
      { "<localleader>a", "<cmd>CodeCompanionChat Toggle<cr>", desc = "CodeCompanion Chat Toggle", mode = { "n", "v" } },
      { "ga", "<cmd>CodeCompanionChat Add<cr>", desc = "CodeCompanion Chat Add", mode = "v" },
    },
  },
}
