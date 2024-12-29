local group   = vim.api.nvim_create_augroup('agjacome', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position when reopening a file
autocmd('BufReadPost', {
    group   = group,
    pattern = '*',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]]
})

-- Remove trailing whitespaces on save
autocmd('BufWritePre', {
    group   = group,
    pattern = '*',
    command = [[if &filetype !~# 'markdown\|text' | silent! %s/\s\+$//e | endif]]
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
        vim.highlight.on_yank({
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
