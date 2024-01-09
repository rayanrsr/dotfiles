return { 
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
{ "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {},
    config = function()
            require("ibl").setup()
    end,
},
{"norcalli/nvim-colorizer.lua"},
    {
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  config = function()
    require('dashboard').setup {
      -- config
        theme='hyper',
        config={
            header= require('ray.ascii'),
                }
    }
  end,
  dependencies = { {'nvim-tree/nvim-web-devicons'}}
},
    -- { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
    { 'rose-pine/neovim', name = 'rose-pine' }, 
    {'nvim-tree/nvim-tree.lua'},
    {'mfussenegger/nvim-dap'},
    {'terrortylor/nvim-comment'},
    {'nvim-treesitter/nvim-treesitter-context'},
    {'akinsho/bufferline.nvim', version = "*", dependencies = 'nvim-tree/nvim-web-devicons'},
    {'liuchengxu/vista.vim'},
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
    {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("refactoring").setup()
    end,
  },
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
    {'christoomey/vim-tmux-navigator', lazy=false},
    { "aserowy/tmux.nvim",
    config = function() return require("tmux").setup() end
    }, 
    {
        "kdheepak/lazygit.nvim",
        -- optional for floating window border decoration
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    },
    {
      "karb94/neoscroll.nvim",
      config = function ()
        require('neoscroll').setup {}
      end
    },
    {"ahmedkhalf/project.nvim",
    config = function()
      require("project_nvim").setup {

        sync_root_with_cwd = true,
      respect_buf_cwd = true,
      update_focused_file = {
        enable = true,
        update_root = true
      },
            }
    end
    },
    {
            'nvimdev/lspsaga.nvim',
    config = function()
        require('lspsaga').setup({})

    end,
    dependencies = {
        'nvim-treesitter/nvim-treesitter', -- optional
        'nvim-tree/nvim-web-devicons',     -- optional
    }
    },
    {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    opts = {} -- this is equalent to setup({}) function
},
    {"windwp/nvim-ts-autotag"},
}

