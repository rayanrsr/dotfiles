return {
  {
    -- "folke/tokyonight.nvim",
    "nyoom-engineering/oxocarbon.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "tiagovla/tokyodark.nvim",
    -- "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
  },
  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "oxocarbon",
    },
  },
}
