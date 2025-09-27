return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      { "saghen/blink.cmp" },
      {
        -- `lazydev` configures Lua LSP for your Neovim config, runtime and plugins
        -- used for completion, annotations and signatures of Neovim apis
        "folke/lazydev.nvim",
        ft = "lua",
        opts = {
          library = {
            -- Load luvit types when the `vim.uv` word is found
            { path = "luvit-meta/library", words = { "vim%.uv" } },
            { path = "/usr/share/awesome/lib/", words = { "awesome" } },
          },
        },
      },
      { "Bilal2453/luvit-meta", lazy = true },
      "williamboman/mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      "WhoIsSethDaniel/mason-tool-installer.nvim",

      { "j-hui/fidget.nvim", opts = {} },
      { "https://git.sr.ht/~whynothugo/lsp_lines.nvim" },

      -- Autoformatting
      "stevearc/conform.nvim",

      -- Schema information
      "b0o/SchemaStore.nvim",
    },
    config = function()
      -- Enable inline completion (Neovim >= 0.12)
      if vim.lsp.inline_completion and not vim.lsp.inline_completion.is_enabled() then
        vim.lsp.inline_completion.enable()
      end
      local capabilities = require("blink.cmp").get_lsp_capabilities()
      require("lspconfig").lua_ls.setup {
        capabilities = capabilities,
      }
      -- Don't do LSP stuff if we're in Obsidian Edit mode
      if vim.g.obsidian then
        return
      end

      local extend = function(name, key, values)
        local mod = require(string.format("lspconfig.configs.%s", name))
        local default = mod.default_config
        local keys = vim.split(key, ".", { plain = true })
        while #keys > 0 do
          local item = table.remove(keys, 1)
          default = default[item]
        end

        if vim.islist(default) then
          for _, value in ipairs(default) do
            table.insert(values, value)
          end
        else
          for item, value in pairs(default) do
            if not vim.tbl_contains(values, item) then
              values[item] = value
            end
          end
        end
        return values
      end

      local capabilities = nil
      if pcall(require, "cmp_nvim_lsp") then
        capabilities = require("cmp_nvim_lsp").default_capabilities()
      end

      local lspconfig = require "lspconfig"

      local servers = {
        bashls = true,
        clangd = {
          settings = {
            clangd = {
              arguments = {
                "--background-index",
                "--clang-tidy",
                "--header-insertion=iwyu",
                "--completion-style=detailed",
                "--fallback-style=Google",
              },
            },
          },
        },
        gopls = {
          manual_install = true,
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = true,
                compositeLiteralFields = true,
                compositeLiteralTypes = true,
                constantValues = true,
                functionTypeParameters = true,
                parameterNames = true,
                rangeVariableTypes = true,
              },
            },
          },
        },
        glsl_analyzer = true,
        lua_ls = {
          -- server_capabilities = {
          --   semanticTokensProvider = vim.NIL,
          -- },
        },
        rust_analyzer = true,
        svelte = true,
        templ = true,
        taplo = true,
        intelephense = {
          settings = {
            intelephense = {
              format = {
                braces = "k&r",
              },
            },
          },
        },

        pyright = true,
        ruff = { manual_install = true },
        -- mojo = { manual_install = true },

        -- Enabled biome formatting, turn off all the other ones generally
        biome = true,
        astro = true,
        -- ts_ls = {
        --   root_dir = require("lspconfig").util.root_pattern "package.json",
        --   single_file = false,
        --   server_capabilities = {
        --     documentFormattingProvider = false,
        --   },
        -- },
        vtsls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
        },
        -- denols = true,
        jsonls = {
          server_capabilities = {
            documentFormattingProvider = false,
          },
          settings = {
            json = {
              schemas = require("schemastore").json.schemas(),
              validate = { enable = true },
            },
          },
        },

        -- cssls = {
        --   server_capabilities = {
        --     documentFormattingProvider = false,
        --   },
        -- },

        yamlls = {
          settings = {
            yaml = {
              schemaStore = {
                enable = false,
                url = "",
              },
              -- schemas = require("schemastore").yaml.schemas(),
            },
          },
        },

        -- elixirls = {
        --   cmd = { "/home/tjdevries/.local/share/nvim/mason/bin/elixir-ls" },
        --   root_dir = require("lspconfig.util").root_pattern { "mix.exs" },
        --   -- server_capabilities = {
        --   --   -- completionProvider = true,
        --   --   definitionProvider = true,
        --   --   documentFormattingProvider = false,
        --   -- },
        -- },






      }



      local servers_to_install = vim.tbl_filter(function(key)
        local t = servers[key]
        if type(t) == "table" then
          return not t.manual_install
        else
          return t
        end
      end, vim.tbl_keys(servers))

      require("mason").setup()
      local ensure_installed = {
        "clangd",
        "clang-format",
        "lua_ls",
        "pyright",
        "ruff",
        "stylua",
        "tailwindcss",
        "typescript-language-server",
        "yamlls",
        "jsonls",
      }

      vim.list_extend(ensure_installed, servers_to_install)
      require("mason-tool-installer").setup { ensure_installed = ensure_installed }

      for name, config in pairs(servers) do
        if config == true then
          config = {}
        end
        config = vim.tbl_deep_extend("force", {}, {
          capabilities = capabilities,
        }, config)

        lspconfig[name].setup(config)
      end

      local disable_semantic_tokens = {
        -- lua = true,
      }

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local bufnr = args.buf
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id), "must have valid client")

          local settings = servers[client.name]
          if type(settings) ~= "table" then
            settings = {}
          end

          vim.opt_local.omnifunc = "v:lua.vim.lsp.omnifunc"
          vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = 0 })
          vim.keymap.set("n", "gr", vim.lsp.buf.references, { buffer = 0 })
          vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { buffer = 0 })
          vim.keymap.set("n", "gT", vim.lsp.buf.type_definition, { buffer = 0 })
          vim.keymap.set("n", "K", vim.lsp.buf.hover, { buffer = 0 })

          vim.keymap.set("n", "<space>cr", vim.lsp.buf.rename, { buffer = 0 })
          vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, { buffer = 0 })
          vim.keymap.set("n", "<space>wd", vim.lsp.buf.document_symbol, { buffer = 0 })

          local filetype = vim.bo[bufnr].filetype
          if disable_semantic_tokens[filetype] then
            client.server_capabilities.semanticTokensProvider = nil
          end

          -- Override server capabilities
          if settings.server_capabilities then
            for k, v in pairs(settings.server_capabilities) do
              if v == vim.NIL then
                ---@diagnostic disable-next-line: cast-local-type
                v = nil
              end

              client.server_capabilities[k] = v
            end
          end
        end,
      })

      require("lsp_lines").setup()
      vim.diagnostic.config { virtual_text = true, virtual_lines = false }

      -- Experimental: Next Edit Suggestions (NES) integration
      -- Set this to true to enable automatic NES updates
      vim.g.copilot_nes = true

      local function setup_nes_updates()
        local ok_snacks, Snacks = pcall(require, "snacks")
        local ok_nes = pcall(require, "copilot-lsp.nes")
        if not ok_snacks or not ok_nes then
          return
        end
        local nes_update = Snacks.util.debounce(function()
          if vim.g.copilot_nes then
            pcall(function()
              require("copilot-lsp.nes").request_nes("copilot")
            end)
          end
        end, { ms = 75 })

        vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
          group = vim.api.nvim_create_augroup("copilot_native_complete", { clear = true }),
          callback = nes_update,
        })

        -- Focus notifications so Copilot knows which buffer is active
        vim.api.nvim_create_autocmd("BufEnter", {
          group = vim.api.nvim_create_augroup("copilot_native_focus", { clear = true }),
          callback = function(ev)
            local buf = ev.buf
            local client = vim.lsp.get_clients({ name = "copilot_ls", bufnr = buf })[1]
            if not client then
              return
            end
            client:notify("textDocument/didFocus", {
              textDocument = { uri = vim.uri_from_bufnr(buf) },
            })
          end,
        })
      end

      setup_nes_updates()

      vim.keymap.set("", "<leader>l", function()
        local config = vim.diagnostic.config() or {}
        if config.virtual_text then
          vim.diagnostic.config { virtual_text = false, virtual_lines = true }
        else
          vim.diagnostic.config { virtual_text = true, virtual_lines = false }
        end
      end, { desc = "Toggle lsp_lines" })

    end,
  },
}