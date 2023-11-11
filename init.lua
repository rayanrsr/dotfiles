require("ray")
-- print("Let's start Lazy!")
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
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
	{'theprimeagen/harpoon'},
	{'mbbill/undotree'},
	{'github/copilot.vim'},
	{'tpope/vim-fugitive'},
	{'williamboman/mason.nvim'},
	{'williamboman/mason-lspconfig.nvim'},
	{'VonHeikemen/lsp-zero.nvim', branch = 'v3.x'},
	{'neovim/nvim-lspconfig'},
	{'hrsh7th/cmp-nvim-lsp'},
	{'hrsh7th/nvim-cmp'},
	{'L3MON4D3/LuaSnip'},
    {'rmagatti/auto-session'},
    {'numToStr/Navigator.nvim'},
}
vim.opt.rtp:prepend(lazypath)
require("lazy").setup(plugins, opts)
vim.cmd([[colorscheme rose-pine]])
vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
