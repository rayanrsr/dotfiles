return {
  {
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "tiagovla/tokyodark.nvim",
    "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("kanagawa").setup({
        -- transparent_background = false,
        -- transparent = true,
      })
    end,
  },
  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "kanagawa",
    },
  },
}
