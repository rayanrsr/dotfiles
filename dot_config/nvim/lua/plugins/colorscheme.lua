return {
  {
    "tiagovla/tokyodark.nvim",
    name = "tokyodark.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      transparent_background = true, -- set background to transparent
      gamma = 1.00, -- adjust the brightness of the theme
    },
    config = function(_, opts)
      require("tokyodark").setup(opts) -- calling setup is optional
      vim.cmd([[colorscheme tokyodark]])
    end,
  },
}
