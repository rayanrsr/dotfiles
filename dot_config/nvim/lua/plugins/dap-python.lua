return {
  "mfussenegger/nvim-dap-python",
  ft = "python",
  dependencies = {
    "mfussenegger/nvim-dap",
    "rcarriga/nvim-dap-ui",
  },
  config = function()
    local dap_python = require("dap-python")
    
    -- Setup DAP Python with the Python path
    -- You can change this to your preferred Python path
    -- For uv environments, this will typically be the active Python
    dap_python.setup("python")
    
    -- Configure Python debugging
    local dap = require("dap")
    
    -- Python configurations
    dap.configurations.python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = function()
          -- Try to use uv first, then fall back to system python
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          
          -- Fall back to system python
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch file with arguments",
        program = "${file}",
        args = function()
          local args_string = vim.fn.input("Arguments: ")
          return vim.split(args_string, " ")
        end,
        pythonPath = function()
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
      {
        type = "python",
        request = "attach",
        name = "Attach remote",
        connect = function()
          local host = vim.fn.input("Host [127.0.0.1]: ")
          host = host ~= "" and host or "127.0.0.1"
          local port = tonumber(vim.fn.input("Port [5678]: ")) or 5678
          return { host = host, port = port }
        end,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch Django",
        program = "${workspaceFolder}/manage.py",
        args = { "runserver", "--noreload" },
        pythonPath = function()
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
        django = true,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch Flask",
        module = "flask",
        env = { FLASK_APP = "app.py" },
        args = { "run", "--debug" },
        pythonPath = function()
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
        jinja = true,
      },
      {
        type = "python",
        request = "launch",
        name = "Launch FastAPI",
        module = "uvicorn",
        args = { "main:app", "--reload" },
        pythonPath = function()
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
      {
        type = "python",
        request = "launch",
        name = "Run pytest",
        module = "pytest",
        args = { "${file}" },
        pythonPath = function()
          local uv_python = vim.fn.system("uv run which python 2>/dev/null"):gsub("\n", "")
          if vim.v.shell_error == 0 and uv_python ~= "" then
            return uv_python
          end
          return vim.fn.exepath("python3") or vim.fn.exepath("python") or "python"
        end,
      },
    }
    
    -- Python-specific keybindings
    vim.keymap.set("n", "<leader>dpr", function() dap_python.test_method() end, { desc = "Test Method" })
    vim.keymap.set("n", "<leader>dpc", function() dap_python.test_class() end, { desc = "Test Class" })
    vim.keymap.set("v", "<leader>dps", function() dap_python.debug_selection() end, { desc = "Debug Selection" })
  end,
} 