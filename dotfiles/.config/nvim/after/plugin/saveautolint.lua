--require('lint').linters_by_ft = {
--  markdown = {'vale',},
--  python = {'ruff', 'mypy'},--{'black', 'isort'}}

--vim.api.nvim_create_autocmd({ "BufWritePost" }, {
--  callback = function()
--    require("lint").try_lint()
--  end,
--})
local ft = require('guard.filetype')

-- Assuming you have guard-collection
ft('python'):fmt('black')
          :append('isort')
          :lint('ruff')
ft('rust'):fmt('rustfmt')
ft('javascript'):fmt('prettier')
                :lint('eslint')
-- Call setup() LAST!
require('guard').setup({
    -- the only options for the setup function
    fmt_on_save = true,
    -- Use lsp if no formatter was defined for this filetype
    lsp_as_default_formatter = false,
})
