return {
  "mfussenegger/nvim-dap",
  dependencies = {
    { "nvim-neotest/nvim-nio" },
    { "rcarriga/nvim-dap-ui" },
    { "theHamsta/nvim-dap-virtual-text" },
    { "nvim-telescope/telescope-dap.nvim" },
  },
  config = function()
    local dap = require("dap")
    local dapui = require("dapui")

    -- DAP UI setup
    dapui.setup({
      controls = {
        element = "repl",
        enabled = true,
        icons = {
          disconnect = "",
          pause = "",
          play = "",
          run_last = "",
          step_back = "",
          step_into = "",
          step_out = "",
          step_over = "",
          terminate = ""
        }
      },
      element_mappings = {},
      expand_lines = true,
      floating = {
        border = "single",
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      force_buffers = true,
      icons = {
        collapsed = "",
        current_frame = "",
        expanded = ""
      },
      layouts = {
        {
          elements = {
            { id = "scopes", size = 0.25 },
            { id = "breakpoints", size = 0.25 },
            { id = "stacks", size = 0.25 },
            { id = "watches", size = 0.25 }
          },
          position = "left",
          size = 40
        },
        {
          elements = {
            { id = "repl", size = 0.5 },
            { id = "console", size = 0.5 }
          },
          position = "bottom",
          size = 10
        }
      },
      mappings = {
        edit = "e",
        expand = { "<CR>", "<2-LeftMouse>" },
        open = "o",
        remove = "d",
        repl = "r",
        toggle = "t"
      },
      render = {
        indent = 1,
        max_value_lines = 100
      }
    })

    -- Virtual text setup
    require("nvim-dap-virtual-text").setup({
      enabled = true,
      enabled_commands = true,
      highlight_changed_variables = true,
      highlight_new_as_changed = false,
      show_stop_reason = true,
      commented = false,
      only_first_definition = true,
      all_references = false,
      clear_on_continue = false,
      display_callback = function(variable, buf, stackframe, node, options)
        if options.virt_text_pos == 'inline' then
          return ' = ' .. variable.value
        else
          return variable.name .. ' = ' .. variable.value
        end
      end,
      virt_text_pos = vim.fn.has 'nvim-0.10' == 1 and 'inline' or 'eol',
      all_frames = false,
      virt_lines = false,
      virt_text_win_col = nil
    })

    -- Auto open/close DAP UI
    dap.listeners.after.event_initialized["dapui_config"] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated["dapui_config"] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited["dapui_config"] = function()
      dapui.close()
    end

    -- DAP signs
    vim.fn.sign_define('DapBreakpoint', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'DapBreakpointCondition', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'DapLogPoint', linehl = '', numhl = '' })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapStopped', linehl = 'DapStoppedLine', numhl = '' })
    vim.fn.sign_define('DapBreakpointRejected', { text = '', texthl = 'DapBreakpointRejected', linehl = '', numhl = '' })

    -- Keybindings
    local keymap = vim.keymap.set
    keymap("n", "<leader>db", function() dap.toggle_breakpoint() end, { desc = "Toggle Breakpoint" })
    keymap("n", "<leader>dB", function() dap.set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, { desc = "Set Conditional Breakpoint" })
    keymap("n", "<leader>dc", function() dap.continue() end, { desc = "Continue" })
    keymap("n", "<leader>dC", function() dap.run_to_cursor() end, { desc = "Run to Cursor" })
    keymap("n", "<leader>dd", function() dap.disconnect() end, { desc = "Disconnect" })
    keymap("n", "<leader>dg", function() dap.session() end, { desc = "Get Session" })
    keymap("n", "<leader>di", function() dap.step_into() end, { desc = "Step Into" })
    keymap("n", "<leader>do", function() dap.step_over() end, { desc = "Step Over" })
    keymap("n", "<leader>du", function() dap.step_out() end, { desc = "Step Out" })
    keymap("n", "<leader>dp", function() dap.pause() end, { desc = "Pause" })
    keymap("n", "<leader>dr", function() dap.repl.toggle() end, { desc = "Toggle REPL" })
    keymap("n", "<leader>ds", function() dap.continue() end, { desc = "Start" })
    keymap("n", "<leader>dt", function() dap.terminate() end, { desc = "Terminate" })
    keymap("n", "<leader>dw", function() require("dap.ui.widgets").hover() end, { desc = "Widgets" })
    keymap("n", "<leader>dU", function() dapui.toggle() end, { desc = "Toggle DAP UI" })
    
    -- DAP UI keybindings
    keymap("n", "<leader>de", function() dapui.eval() end, { desc = "Eval" })
    keymap("v", "<leader>de", function() dapui.eval() end, { desc = "Eval" })
  end,
}