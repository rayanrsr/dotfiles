return {
  {
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    "rose-pine/neovim",
    -- "tiagovla/tokyodark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        styles = {
          transparency = true,
          italic = true,
          bold = true,
        },
      })
    end,
  },
  -- Configure LazyVim to load rose-pine
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "rose-pine",
    },
  },
}
