return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = {
    lsp = {
      override = {
        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
        ["vim.lsp.util.stylize_markdown"] = true,
        -- set to true only if you use nvim-cmp
        ["cmp.entry.get_documentation"] = false,
      },
      progress = { enabled = true, view = "mini" },
      hover = { enabled = true },
      signature = { enabled = true },
      message = { enabled = true, view = "notify" },
      documentation = {
        view = "hover",
        opts = { lang = "markdown", replace = true, render = "plain", format = { "{message}" }, win_options = { concealcursor = "n", conceallevel = 3 } },
      },
    },
    presets = {
      bottom_search = true,
      command_palette = true,
      long_message_to_split = true,
      inc_rename = false,
      lsp_doc_border = false,
    },
    cmdline = { enabled = true, view = "cmdline_popup" },
    messages = { enabled = true, view = "notify", view_search = "virtualtext" },
    popupmenu = { enabled = true, backend = "nui" },
    notify = { enabled = true, view = "notify" },
  },
  dependencies = {
    "MunifTanjim/nui.nvim",
    "rcarriga/nvim-notify",
  },
  config = function(_, opts)
    require("noice").setup(opts)
    -- Handy keymaps
    vim.keymap.set("n", "<leader>nl", function()
      require("noice").cmd("last")
    end, { desc = "Noice: Last message" })
    vim.keymap.set("n", "<leader>nh", function()
      require("noice").cmd("history")
    end, { desc = "Noice: Message history" })
  end,
}


