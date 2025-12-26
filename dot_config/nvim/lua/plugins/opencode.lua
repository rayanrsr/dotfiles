return {
  "sudo-tee/opencode.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    {
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        anti_conceal = { enabled = false },
        file_types = { "markdown", "opencode_output" },
      },
      ft = { "markdown", "Avante", "copilot-chat", "opencode_output" },
    },
    "saghen/blink.cmp",
    "folke/snacks.nvim",
  },
  config = function()
    require("opencode").setup({
      preferred_picker = "snacks", -- Use snacks.nvim as picker
      preferred_completion = "blink", -- Use blink.cmp for completion
      default_global_keymaps = true, -- Enable default global keymaps
      default_mode = "build", -- Default to build mode
      keymap_prefix = "<leader>o", -- Use <leader>o prefix for keymaps
      -- Custom keymaps can be added here if needed
    })
  end,
}
