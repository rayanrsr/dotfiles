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
}
