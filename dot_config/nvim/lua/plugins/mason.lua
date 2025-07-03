return {
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- Language servers
        "basedpyright",
        "lua-language-server",
        -- Tools
        "yamllint",
      },
    },
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        "basedpyright",
        "lua_ls",
      },
      -- Disable automatic setup to prevent duplicates
      automatic_setup = false,
    },
  },
  {
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    dependencies = {
      "williamboman/mason.nvim",
    },
    opts = {
      ensure_installed = {
        -- Linters
        "yamllint",
        -- Additional tools can be added here
      },
      auto_update = true,
      run_on_start = true,
    },
  },
}
