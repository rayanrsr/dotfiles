return {
  {
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    -- "rose-pine/neovim",
    "sam4llis/nvim-tundra",
    -- "tiagovla/tokyodark.nvim",
    name = "tundra",
    lazy = false,
    priority = 1000,
    config = function()
      require("nvim-tundra").setup({
        transparent_background = true,
      })

      -- Set the colorscheme
      vim.cmd("colorscheme tundra")
      vim.opt.background = "dark"
      vim.g.tundra_biome = "arctic"
    end,
  },
}
