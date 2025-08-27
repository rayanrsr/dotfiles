return {
  'stevearc/conform.nvim',
  opts = {
    -- Map of filetype to formatters
    formatters_by_ft = {
      -- Python: Use all ruff formatters in sequence
      python = { "ruff_organize_imports", "ruff_fix", "ruff_format" },
      
      -- Lua
      lua = { "stylua" },
      
      -- JavaScript/TypeScript
      javascript = { "prettierd", "prettier", stop_after_first = true },
      typescript = { "prettierd", "prettier", stop_after_first = true },
      javascriptreact = { "prettierd", "prettier", stop_after_first = true },
      typescriptreact = { "prettierd", "prettier", stop_after_first = true },
      
      -- Web
      html = { "prettierd", "prettier", stop_after_first = true },
      css = { "prettierd", "prettier", stop_after_first = true },
      scss = { "prettierd", "prettier", stop_after_first = true },
      json = { "prettierd", "prettier", stop_after_first = true },
      jsonc = { "prettierd", "prettier", stop_after_first = true },
      
      -- Markdown
      markdown = { "prettierd", "prettier", stop_after_first = true },
      
      -- YAML
      yaml = { "prettierd", "prettier", stop_after_first = true },
      
      -- Go
      go = { "goimports", "gofumpt" },
      
      -- Rust
      rust = { "rustfmt", lsp_format = "fallback" },
      
      -- C/C++
      c = { "clang_format", lsp_format = "fallback" },
      cpp = { "clang_format", lsp_format = "fallback" },
      cxx = { "clang_format", lsp_format = "fallback" },
      
      -- Shell
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      
      -- TOML
      toml = { "taplo" },
      
      -- XML
      xml = { "xmllint" },
      
      -- Use the "*" filetype to run formatters on all filetypes
      ["*"] = { "codespell" },
      
      -- Use the "_" filetype to run formatters on filetypes that don't have other formatters configured
      ["_"] = { "trim_whitespace" },
    },
    
    -- Set this to change the default values when calling conform.format()
    default_format_opts = {
      lsp_format = "fallback",
      timeout_ms = 3000,
      async = false,
      quiet = false,
    },
    
    -- Format on save
    format_on_save = {
      -- These options will be passed to conform.format()
      timeout_ms = 3000,
      lsp_format = "fallback",
    },
    
    -- Set the log level
    log_level = vim.log.levels.ERROR,
    
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = false,
    
    -- Custom formatters and overrides for built-in formatters
    formatters = {
      -- Customize shfmt for shell scripts
      shfmt = {
        prepend_args = { "-i", "2", "-ci" }, -- 2 space indentation, indent switch cases
      },
      
      -- Customize stylua for Lua
      stylua = {
        prepend_args = { "--indent-type", "Spaces", "--indent-width", "2" },
      },
      
      -- Ruff formatters are already well configured by default, but we can customize if needed
      ruff_format = {
        -- You can add custom args here if needed
        -- prepend_args = { "--config", "pyproject.toml" },
      },
      
      ruff_fix = {
        -- You can add custom args here if needed
        -- prepend_args = { "--fix" },
      },
      
      ruff_organize_imports = {
        -- You can add custom args here if needed
      },
      
      -- Customize clang-format for C/C++
      clang_format = {
        prepend_args = { 
          "--style=Google",  -- Use Google style as default
          "--fallback-style=LLVM"  -- Fallback to LLVM style if no config found
        },
      },
    },
  },
  
  -- Load conform on file read/write
  event = { "BufReadPre", "BufNewFile" },
  
  -- Key mappings
  keys = {
    {
      "<leader>mp",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
    {
      "<leader>mP",
      function()
        require("conform").format({ 
          formatters = { "ruff_organize_imports", "ruff_fix", "ruff_format" }, 
          async = true 
        })
      end,
      mode = "",
      desc = "Format Python with all ruff formatters",
      ft = "python",
    },
  },
  
  -- Commands
  cmd = { "ConformInfo" },
}
