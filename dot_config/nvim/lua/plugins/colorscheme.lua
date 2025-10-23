return {
  {
    "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- transparent_background = false,
      })
    end,
  },
  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
