local group   = vim.api.nvim_create_augroup('agjacome', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position when reopening a file
autocmd('BufReadPost', {
    group   = group,
    pattern = '*',
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end
})

-- Remove trailing whitespaces on save
autocmd('BufWritePre', {
    group   = group,
    pattern = '*',
    callback = function()
        local ft = vim.bo.filetype
        if ft ~= 'markdown' and ft ~= 'text' then
            local view = vim.fn.winsaveview()
            vim.cmd([[silent! %s/\s\+$//e]])
            vim.fn.winrestview(view)
        end
    end
})

-- Clear command from ruler after 5ms
autocmd('CmdlineLeave', {
    group = group,
    pattern = '*',
    callback = function()
        vim.fn.timer_start(500, function() vim.cmd('echon " "') end)
    end
})

-- Highlight yanked text
autocmd('TextYankPost', {
    group    = group,
    pattern  = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 150
        })
    end
})

-- Copy current file relative path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
