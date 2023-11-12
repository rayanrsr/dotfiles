require('lint').linters_by_ft = {
  markdown = {'vale',},
  python = {'flake8', 'ruff', 'mypy'},
}

vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  callback = function()
    require("lint").try_lint()
  end,
})
