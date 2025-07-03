return {
  {
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    "rose-pine/neovim",
    -- "tiagovla/tokyodark.nvim",
    name = "rose-pine",
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
      -- Set the colorscheme
      vim.cmd("colorscheme rose-pine")
    end,
  },
}
