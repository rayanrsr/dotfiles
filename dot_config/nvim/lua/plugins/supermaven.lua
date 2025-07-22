return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  cmd = {
    "SupermavenUseFree",
    "SupermavenUsePro",
  },
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",
      clear_suggestion = "<C-]>",
    },
    -- keymaps = {
    --   accept_suggestion = nil, -- handled by nvim-cmp / blink.cmp
    -- },
    -- disable_inline_completion = vim.g.ai_cmp,
    -- ignore_filetypes = { "bigfile", "snacks_input", "snacks_notif" },
    -- ignore_filetypes = { "snacks_input", "snacks_notif" },
  },
}
