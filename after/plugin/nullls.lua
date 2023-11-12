local null_ls = require("null-ls")

null_ls.setup({
    sources = {
        null_ls.builtins.formatting.stylua,
        null_ls.builtins.diagnostics.mypy,
        null_ls.builtins.diagnostics.flake8,
        null_ls.builtins.diagnostics.black,
        null_ls.builtins.diagnostics.isort,
        null_ls.builtins.diagnostics.ruff,
        null_ls.builtins.completion.spell,
    },
})
