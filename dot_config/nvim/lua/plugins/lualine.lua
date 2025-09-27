return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  opts = function()
    local function python_env()
      -- Try virtualenv variables
      local venv = vim.env.VIRTUAL_ENV or vim.env.CONDA_PREFIX or vim.env.PYENV_VIRTUAL_ENV
      if venv and venv ~= "" then
        return string.format("󰌠 %s", vim.fn.fnamemodify(venv, ":t"))
      end
      -- Try pyproject/venv names via lsp info or poetry
      local poetry_env = vim.fn.systemlist("poetry env info -p 2>/dev/null")[1]
      if poetry_env and poetry_env ~= "" then
        return string.format("󰌠 %s", vim.fn.fnamemodify(poetry_env, ":t"))
      end
      return ""
    end

    return {
      options = {
        theme = "horizon",
        section_separators = { left = "", right = "" },
        component_separators = { left = "│", right = "│" },
        globalstatus = true,
        disabled_filetypes = {
          statusline = {},
          winbar = {},
        },
      },
      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = { { "branch" }, { "diff" }, { "diagnostics" } },
        lualine_c = { { "filename", path = 1 } },
        lualine_x = {
          { python_env },
          { "filetype", icon_only = false },
          { "encoding" },
          { "fileformat" },
        },
        lualine_y = { { "progress" } },
        lualine_z = { { "location" } },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 1 } },
        lualine_x = { { "location" } },
        lualine_y = {},
        lualine_z = {},
      },
    }
  end,
}


