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
            "prettier",
            "cmake",
            "mypy",
            "ruff",
            "rust-analyzer",
            "pyright",
            },
    automatic_installation = true,
}
