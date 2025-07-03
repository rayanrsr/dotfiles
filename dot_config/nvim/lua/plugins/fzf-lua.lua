return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      -- Use sane defaults
      winopts = {
        height = 0.85,
        width = 0.80,
        preview = {
          layout = "flex",
          flip_columns = 120,
        },
      },
    })
  end,
  keys = {
    {
      "<C-p>",
      function()
        require("fzf-lua").files()
      end,
      desc = "Find files",
    },
    {
      "<leader>ps",
      function()
        require("fzf-lua").live_grep()
      end,
      desc = "Live grep",
    },
  },
} 