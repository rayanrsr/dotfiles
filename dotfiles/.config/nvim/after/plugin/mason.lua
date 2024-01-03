require("mason").setup({
    ui = {
        icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗"
        }
    }
})

require("mason-lspconfig").setup{
    ensure_installed = {
"es-lint-lsp",
            "eslint",
            "prettier",
            "black",
            "cmake",
            "mypy",
            "ruff",
            "rust-analyzer",
            "pyright",
            "svelte",
           "tsls",
            "debugpy",
            "flake8",
            "black",
            "python-lsp-server",
            "isort",
            },
    automatic_installation = true,
}
