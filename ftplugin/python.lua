local function run_curr_python_file()
    -- Get file name in the current buffer
    local file_name = vim.api.nvim_buf_get_name(0)

    -- Get terminal codes for running python file
    local py_cmd = vim.api.nvim_replace_termcodes("python \"" .. file_name .. "\"<cr>", true, false, true)

    -- Get terminal codes for key-press sequence to launch toggleterm in LunarVim
    -- (one may have to use <C-\\> for Ctrl + backslash)
    local lnrvim_togterm_cmd = vim.api.nvim_replace_termcodes("<M-1>", true, false, true)

    -- Press keys to launch toggleterm in LunarVim
    vim.api.nvim_feedkeys(lnrvim_togterm_cmd, "m", true)

    -- Press keys to run python command on current file
    vim.api.nvim_feedkeys(py_cmd, "t", false)
end

vim.keymap.set({'n'}, '<A-r>', '', { 
    desc = "Run .py file via toggle term", 
    callback = run_curr_python_file
})
