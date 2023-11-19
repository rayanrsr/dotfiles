require("ray")

-- print("Let's start Lazy!")
local lazypath = vim.fn.stdpath("data" ) .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
plugins = { 
  {'nvim-telescope/telescope.nvim', tag = '0.1.3', dependencies = { 'nvim-lua/plenary.nvim' } }, { 'rose-pine/neovim', name = 'rose-pine' }, {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate", 
  config = function () 
      local configs = require("nvim-treesitter.configs")

      configs.setup({
          ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "elixir", "heex", "javascript", "html", "rust", "typescript", "python"},
          sync_install = false,
          highlight = { enable = true },
          indent = { enable = true },
        })
    end
    },
    {'nvim-tree/nvim-tree.lua'},
    {'mfussenegger/nvim-dap'},
    {'terrortylor/nvim-comment'},
    {'nvim-treesitter/nvim-treesitter-context'},
    {'akinsho/toggleterm.nvim'},
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {
        'mfussenegger/nvim-dap-python',
        ft = {'python'},
        dependencies = {
            {
                'mfussenegger/nvim-dap',
                'rcarriga/nvim-dap-ui',
            },
        },
        config = function()
            require('dap-python').setup('~/.pyenv/versions/debugpy/bin/python')
        end,

    },
    {
        'rcarriga/nvim-dap-ui',
        dependencies = {
            {'mfussenegger/nvim-dap'},
        },
        config = function()
            local dap = require('dap')
            local dapui = require('dapui')
            dapui.setup() -- enables the UI
            dap.listeners.after.event_initialized['dapui_config'] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated['dapui_config'] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited['dapui_config'] = function()
                dapui.close()
            end
        end,
    },
    {'theprimeagen/harpoon'},
	{'mbbill/undotree'},
	{'github/copilot.vim'},
    -- Fugitive is a Git wrapper so awesome, it should be illegal
	{'tpope/vim-fugitive'},
	{
        'williamboman/mason.nvim',
        opts = {
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
        },
    },
    {
      "folke/which-key.nvim",
      event = "VeryLazy",
      init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 300
      end,
      opts = {
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
      }
    },
    {'averms/black-nvim'},
    {'mfussenegger/nvim-lint'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'lukas-reineke/lsp-format.nvim', dependencies = {'neovim/nvim-lspconfig'}},
    {'simrat39/rust-tools.nvim', ft="rust", dependencies={'neovim/nvim-lspconfig'} },
    {'L3MON4D3/LuaSnip'},
    {'hrsh7th/cmp-path'},
    {'rmagatti/auto-session'},
    {'nvim-lualine/lualine.nvim'},
    {'kmontocam/nvim-conda'},
    {'gelguy/wilder.nvim'},
    {
        "nvimdev/guard.nvim",
    -- Builtin configuration, optional
        dependencies = {
        "nvimdev/guard-collection",
    }
    },
    {'numToStr/Navigator.nvim'},
    {'prichrd/netrw.nvim'},
    {
      "folke/tokyonight.nvim",
      lazy = false,
      priority = 1000,
      opts = {},
    }
}
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, opts)
-- vim.cmd([[colorscheme rose-pine]])
vim.cmd([[colorscheme tokyonight-night]])
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
