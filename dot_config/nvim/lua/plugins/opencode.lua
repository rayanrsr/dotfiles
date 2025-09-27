return {
  'NickvanDyke/opencode.nvim',
  dependencies = {
    -- Snacks is recommended for better prompt input and embedded terminal UX.
    'folke/snacks.nvim',
  },
  config = function()
    vim.g.opencode_opts = vim.g.opencode_opts or {}

    -- Required for opts.auto_reload behavior in opencode.nvim
    vim.opt.autoread = true

    local map = vim.keymap.set
    local ok, opencode = pcall(require, 'opencode')
    if not ok then
      return
    end

    -- Recommended keymaps from the README
    map('n', '<leader>ot', function() opencode.toggle() end, { desc = 'OpenCode: Toggle' })
    map('n', '<leader>oA', function() opencode.ask() end, { desc = 'OpenCode: Ask' })
    map('n', '<leader>oa', function() opencode.ask('@cursor: ') end, { desc = 'OpenCode: Ask about cursor' })
    map('v', '<leader>oa', function() opencode.ask('@selection: ') end, { desc = 'OpenCode: Ask about selection' })
    map('n', '<leader>o+', function() opencode.append_prompt('@buffer') end, { desc = 'OpenCode: Add buffer to prompt' })
    map('v', '<leader>o+', function() opencode.append_prompt('@selection') end, { desc = 'OpenCode: Add selection to prompt' })
    map('n', '<leader>on', function() opencode.command('session_new') end, { desc = 'OpenCode: New session' })
    map('n', '<leader>oy', function() opencode.command('messages_copy') end, { desc = 'OpenCode: Copy last response' })
    map('n', '<S-C-u>', function() opencode.command('messages_half_page_up') end, { desc = 'OpenCode: Messages half page up' })
    map('n', '<S-C-d>', function() opencode.command('messages_half_page_down') end, { desc = 'OpenCode: Messages half page down' })
    map({ 'n', 'v' }, '<leader>os', function() opencode.select() end, { desc = 'OpenCode: Select prompt' })

    -- Example custom prompt
    map('n', '<leader>oe', function() opencode.prompt('Explain @cursor and its context') end, { desc = 'OpenCode: Explain this code' })
  end,
}


