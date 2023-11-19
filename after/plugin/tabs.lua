local bufferline = require("bufferline")
bufferline.setup {
    options = {
        numbers = function(opts)
            local marks = require('harpoon').get_mark_config().marks
            local bufname = vim.fn.bufname(opts.id)
            
            for i, mark in ipairs(marks) do
            	if bufname == mark.filename then
                    return i
            	end
            end
            
            return -1
	end,
	custom_filter = function(buf_number)
            local marks = require('harpoon').get_mark_config().marks
            for _, mark in ipairs(marks) do
            	if vim.fn.bufname(buf_number) == mark.filename then
            	    return true
            	end
            end
            return false
	end,
	sort_by = function(buffer_a, buffer_b)
            local a = 1
            local b = 1
            
            local marks = require('harpoon').get_mark_config().marks
            for _, mark in ipairs(marks) do
            	if vim.fn.bufname(buffer_a.id) == mark.filename then
                    a = 0
                    break
            	elseif vim.fn.bufname(buffer_b.id) == mark.filename then
                    b = 0
                    break
        	end
            end
            return a < b
	end,
    },
}

