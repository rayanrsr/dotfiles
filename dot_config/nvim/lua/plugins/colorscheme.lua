return {
  {
    -- "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "tiagovla/tokyodark.nvim",
    -- "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("rose-pine").setup({
        variant = "auto", -- auto, main, moon, or dawn
        dark_variant = "main", -- main, moon, or dawn
        bold_vert_split = false,
        dim_nc_background = false,
        disable_background = true, -- Set background to transparent
        disable_float_background = true, -- Set floating windows to transparent
        disable_italics = false,
        styles = {
          transparency = true,
        },
        groups = {
          background = "NONE",
          background_nc = "NONE",
          panel = "NONE",
          panel_nc = "NONE",
          border = "NONE",
          comment = "italic",
        },
      })

      -- Apply the colorscheme
      vim.cmd.colorscheme("rose-pine")
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
