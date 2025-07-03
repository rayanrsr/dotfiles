---@diagnostic disable-next-line: unused-local
local function generate_slash_commands()
  local commands = {}
  for _, command in ipairs({ "buffer", "file", "help", "symbols" }) do
    commands[command] = {
      opts = {
        provider = "fzf-lua", -- using fzf-lua as the provider
      },
    }
  end
  return commands
end

return {
  {
    "olimorris/codecompanion.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    enabled = true,
    opts = {
      gemini = function()
        return require("codecompanion.adapters").extend("gemini", {
          schema = {
            model = {
              default = "gemini-2.5-flash-preview-05-20",
            },
          },
          env = {
            api_key = "GEMINI_API_KEY",
          },
        })
      end,
      display = {
        chat = {
          intro_message = "Welcome to CodeCompanion ✨! Press ? for options",
          show_header_separator = false, -- Show header separators in the chat buffer? Set this to false if you're using an external markdown formatting plugin
          auto_scroll = false,
        },
      },
      strategies = {
        chat = {
          adapter = {
            name = "gemini",
            model = "gemini-2.5-flash-preview-05-20",
          },
          roles = {
            llm = "CodeCompanion",
            user = "Me",
          },
          slash_commands = generate_slash_commands(),
          keymaps = {
            close = {
              modes = {
                n = "q",
              },
              index = 3,
              callback = "keymaps.close",
              description = "Close Chat",
            },
            stop = {
              modes = {
                n = "<C-c>",
              },
              index = 4,
              callback = "keymaps.stop",
              description = "Stop Request",
            },
          },
        },
      },
      inline = {
        adapter = "gemini",
      },
    },
    keys = {
      {
        "<leader>aa",
        "<cmd>CodeCompanionActions<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion actions",
      },
      {
        "<leader>ac",
        "<cmd>CodeCompanionChat Toggle<cr>",
        mode = { "n", "v" },
        noremap = true,
        silent = true,
        desc = "CodeCompanion chat",
      },
      {
        "<leader>ad",
        "<cmd>CodeCompanionChat Add<cr>",
        mode = "v",
        noremap = true,
        silent = true,
        desc = "CodeCompanion add to chat",
      },
    },
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown", "codecompanion" },
  },
}
