local gemini_prompt = [[
You are the backend of an AI-powered code completion engine. Your task is to
provide code suggestions based on the user's input. The user's code will be
enclosed in markers:

- `<contextAfterCursor>`: Code context after the cursor
- `<cursorPosition>`: Current cursor location
- `<contextBeforeCursor>`: Code context before the cursor
]]

local gemini_few_shots = {}

gemini_few_shots[1] = {
  role = "user",
  content = [[
# language: python
<contextBeforeCursor>
def fibonacci(n):
    <cursorPosition>
<contextAfterCursor>

fib(5)]],
}

local gemini_chat_input_template =
  "{{{language}}}\n{{{tab}}}\n<contextBeforeCursor>\n{{{context_before_cursor}}}<cursorPosition>\n<contextAfterCursor>\n{{{context_after_cursor}}}"

return {
  "milanglacier/minuet-ai.nvim",
  -- Ensure minuet loads before completion engines
  priority = 1000,
  event = "VeryLazy",
  config = function()
    require("minuet").setup({
      provider = "gemini",
      provider_options = {
        gemini = {
          model = "gemini-2.0-flash",
          api_key = "GEMINI_API_KEY", -- This should be the env var name, not the actual key
        },
      },
      -- Configure virtual text to work like Copilot
      virtualtext = {
        auto_trigger_ft = { "*" }, -- Enable for all file types
        keymap = {
          -- accept whole completion with Tab (like Copilot)
          accept = '<Tab>',
          -- accept one line with Shift+Tab
          accept_line = '<S-Tab>',
          -- accept n lines (prompts for number)
          accept_n_lines = '<A-z>',
          -- Cycle to prev completion item, or manually invoke completion
          prev = '<A-[>',
          -- Cycle to next completion item, or manually invoke completion
          next = '<A-]>',
          dismiss = '<A-e>',
        },
        -- Don't show virtual text when completion menu is visible
        show_on_completion_menu = false,
      },
      -- Disable auto completion for blink and cmp since we're using virtual text
      cmp = {
        enable_auto_complete = false,
      },
      blink = {
        enable_auto_complete = false,
      },
      -- Optimize for faster virtual text responses
      throttle = 300, -- Faster response for virtual text
      debounce = 150, -- Quick debounce for virtual text
      -- Set notification level to warn to reduce noise
      notify = "warn",
      -- Ensure we have enough completion items for virtual text cycling
      n_completions = 3,
      -- Faster timeout for virtual text
      request_timeout = 2,
    })
  end,
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
}
