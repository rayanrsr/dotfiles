-- Custom highlight for Avante completion items
vim.api.nvim_set_hl(0, 'BlinkCmpKindAvante', { default = false, fg = '#89b4fa' })

return {
  'saghen/blink.cmp',
  dependencies = {
    'Kaiser-Yang/blink-cmp-avante',
    -- Other dependencies can be added here
  },
  opts = {
    sources = {
      -- Add 'avante' to the list of default sources, replace 'luasnip' with 'snippets'
      default = { 'avante', 'lsp', 'path', 'snippets', 'buffer' },
      providers = {
        avante = {
          module = 'blink-cmp-avante',
          name = 'Avante',
          opts = {
            -- Options for blink-cmp-avante can be configured here
          }
        },
        snippets = {
          preset = 'luasnip'
        }
      },
    }
  }
} 