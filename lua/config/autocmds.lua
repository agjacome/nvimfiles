local group   = vim.api.nvim_create_augroup('config', { clear = true })
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

-- Clear command from ruler after 500ms
autocmd('CmdlineLeave', {
    group = group,
    pattern = '*',
    callback = function()
        vim.defer_fn(function() vim.cmd('echon " "') end, 500)
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
