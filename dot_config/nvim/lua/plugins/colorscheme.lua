return {
  -- Configure LazyVim to load tokyodark
  {
    "tiagovla/tokyodark.nvim",
    opts = {
      -- custom options here
      transparent_background = true,
    },
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyodark",
    },
  },
}
