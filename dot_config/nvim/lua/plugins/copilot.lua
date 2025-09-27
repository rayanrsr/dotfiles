return {
  "copilotlsp-nvim/copilot-lsp",
  init = function()
    vim.g.copilot_nes_debounce = 500
    vim.lsp.enable("copilot_ls")

    -- Tab: accept NES suggestion (with fallback for <C-i> in normal mode)
    vim.keymap.set("n", "<Tab>", function()
      local bufnr = vim.api.nvim_get_current_buf()
      local state = vim.b[bufnr].nes_state
      if state then
        local _ = require("copilot-lsp.nes").walk_cursor_start_edit()
          or (require("copilot-lsp.nes").apply_pending_nes() and require("copilot-lsp.nes").walk_cursor_end_edit())
        return nil
      else
        return "<C-i>"
      end
    end, { desc = "Accept Copilot NES suggestion", expr = true })

    -- Esc: clear suggestion if visible
    vim.keymap.set("n", "<Esc>", function()
      if not require("copilot-lsp.nes").clear() then
        return "<Esc>"
      end
    end, { desc = "Clear Copilot suggestion or fallback", expr = true })

    -- Optional baseline setup
    local ok, copilot_lsp = pcall(require, 'copilot-lsp')
    if ok then
      copilot_lsp.setup({
        nes = {
          move_count_threshold = 3,
        },
      })
    end

    -- Next Edit Suggestion navigation (best-effort; depends on available NES APIs)
    local function nes_try(fns)
      local ok2, nes = pcall(require, 'copilot-lsp.nes')
      if not ok2 then
        return vim.notify('Copilot NES not available', vim.log.levels.WARN)
      end
      for _, fn in ipairs(fns) do
        if type(nes[fn]) == 'function' then
          return nes[fn]()
        end
      end
      vim.notify('Copilot NES: no matching function found', vim.log.levels.WARN)
    end

    -- Next/Previous suggestion (Alt-] / Alt-[)
    vim.keymap.set({ 'n', 'i' }, '<M-]>', function()
      return nes_try({ 'next', 'select_next', 'cycle_next', 'jump_next' })
    end, { desc = 'Copilot NES: Next edit suggestion' })

    vim.keymap.set({ 'n', 'i' }, '<M-[>', function()
      return nes_try({ 'prev', 'previous', 'select_prev', 'cycle_prev', 'jump_prev' })
    end, { desc = 'Copilot NES: Previous edit suggestion' })
  end,
}
