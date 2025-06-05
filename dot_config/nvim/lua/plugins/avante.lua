vim.api.nvim_set_hl(0, "MyAvanteCurrentGroup", {
  fg = nil,
  bg = "#9c1e1e",
})


vim.api.nvim_set_hl(0, "MyAvanteIncomingGroup", {
  fg = nil,
  bg = "#258036",
})

return {
  "yetone/avante.nvim",
  event = "VeryLazy",
  lazy = false,
  version = false,
  build = "make",
  dependencies = {
    "stevearc/dressing.nvim",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "echasnovski/mini.icons", -- optional
    {
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
          use_absolute_path = true,
        },
      },
    },
    {
      "MeanderingProgrammer/render-markdown.nvim",
      ft = { "markdown", "Avante" },
      opts = {
        file_types = { "markdown", "Avante" },
      },
    },
  },
  opts = {
    provider = "gemini", -- Recommend using Claude
    highlights = {
      diff = {
        current = "MyAvanteCurrentGroup",
        incoming = "MyAvanteIncomingGroup"
      }
    },
    behaviour = {
      auto_suggestions = false,
      auto_set_highlight_group = true,
      auto_set_keymaps = true,
      auto_apply_diff_after_generation = false,
      support_paste_from_clipboard = false,
    },
    gemini = {
      model = "gemini-2.5-flash-preview-04-17",
      temperature = 0,
      max_tokens = 4096,
    },
  },
}
