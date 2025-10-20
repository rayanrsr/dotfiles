return {
  "folke/sidekick.nvim",
  opts = {
    -- enable tmux/zellij multiplexer sessions so AI CLIs persist across neovim restarts
    cli = {
      mux = {
        enabled = true,
        backend = "tmux", -- change to "zellij" if you prefer
      },
      -- register Cursor CLI agent
      tools = {
        cursor = {
          -- Cursor CLI agent binary; ensure it's installed and on PATH
          cmd = { "cursor-agent" },
        },
      },
    },
  },
  keys = {
    {
      "<tab>",
      function()
        if not require("sidekick").nes_jump_or_apply() then
          return "<Tab>"
        end
      end,
      expr = true,
      mode = { "n", "i" },
      desc = "Goto/Apply Next Edit Suggestion",
    },
    {
      "<c-.>",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle",
      mode = { "n", "t", "i", "x" },
    },
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle()
      end,
      desc = "Sidekick Toggle CLI",
    },
    {
      "<leader>as",
      function()
        require("sidekick.cli").select()
      end,
      desc = "Select CLI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Detach a CLI Session",
    },
    {
      "<leader>at",
      function()
        require("sidekick.cli").send({ msg = "{this}" })
      end,
      mode = { "x", "n" },
      desc = "Send This",
    },
    {
      "<leader>af",
      function()
        require("sidekick.cli").send({ msg = "{file}" })
      end,
      desc = "Send File",
    },
    {
      "<leader>av",
      function()
        require("sidekick.cli").send({ msg = "{selection}" })
      end,
      mode = { "x" },
      desc = "Send Visual Selection",
    },
    {
      "<leader>ap",
      function()
        require("sidekick.cli").prompt()
      end,
      mode = { "n", "x" },
      desc = "Sidekick Select Prompt",
    },
    -- Quick toggle for Cursor agent specifically
    {
      "<leader>ac",
      function()
        require("sidekick.cli").toggle({ name = "cursor", focus = true })
      end,
      desc = "Sidekick Toggle Cursor Agent",
    },
  },
}


