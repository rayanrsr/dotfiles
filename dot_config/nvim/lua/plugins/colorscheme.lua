return {
  {
    "folke/tokyonight.nvim",
    -- "nyoom-engineering/oxocarbon.nvim",
    -- "rose-pine/neovim",
    -- "catppuccin/nvim",
    -- "tiagovla/tokyodark.nvim",
    -- "rebelot/kanagawa.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("tokyonight").setup({
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        -- options: bold, italic, underline, undercurl, underdouble, underdotted, underdashed, strikethrough, reverse, nocombine, default
        styles = {
          comments = { italic = true },
          keywords = { italic = true },
          functions = {},
          variables = {},
          -- Background styles. Can be "dark", "transparent" or "normal"
          sidebars = "transparent", -- style for sidebars, see below
          floats = "transparent", -- style for floating windows
        },
        -- Set a darker background on sidebar-like windows. e.g. ["qf", "vista_kind", "terminal", "packer"]
        sidebars = { "qf", "vista_kind", "terminal", "packer" },
        -- Adjust the "bright" color of the palette, can be used to make the theme less bright or more bright.
        -- Value: number between 0 and 1, default: 0.5
        day_brightness = 0.3,
        -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine** plugins.
        hide_inactive_statusline = false,
        -- When `true`, section separators are rounded
        dim_inactive = false,
        -- lualine_bold = false,
        -- You can override specific color groups to use other groups or a hex color
        -- function will be called with a ColorScheme table
        on_colors = function(colors) end,
        -- You can override specific highlights to use other groups or a hex color
        -- function will be called with a Highlights and ColorScheme table
        on_highlights = function(highlights, colors) end,
        -- transparent background
        transparent = true,
        -- terminal colors
        terminal_colors = true,
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
