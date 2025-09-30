return {
  'default-anton/sidekick.nvim',
  dependencies = {
    'folke/snacks.nvim',
  },
  config = function()
    local ok, sidekick = pcall(require, 'sidekick')
    if not ok then
      return
    end

    sidekick.setup({
      cli = {
        default_tool = 'opencode',
      },
    })

    local map = vim.keymap.set
    map('n', '<leader>aa', function()
      require('sidekick.cli').toggle({ focus = true })
    end, { desc = 'Sidekick Toggle CLI' })

    map('n', '<leader>ap', function()
      require('sidekick.cli').select_prompt()
    end, { desc = 'Sidekick Prompt Picker' })
  end,
}


