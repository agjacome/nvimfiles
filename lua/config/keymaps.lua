local Opts = require('config.util')

-- leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disabled
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'q/', '<nop>')
vim.keymap.set('n', 'q?', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- navigation
vim.keymap.set('n', '<tab>', ':bnext<cr>', Opts('Buffer- Next'))
vim.keymap.set('n', '<s-tab>', ':bprevious<cr>', Opts('Buffer- Previous'))

-- diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, Opts('Diagnostics - Open'))
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
end, Opts('Diagnostics - Previous'))
vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
end, Opts('Diagnostics - Next'))

-- quickfix
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('quickfix', {}),
    pattern = 'qf',
    callback = function(event)
        vim.keymap.set('n', '<cr>', '<cr>', { buffer = event.buf })
    end,
})

-- custom
vim.keymap.set('n', '<leader>X', '<cmd>source %<cr>', Opts('Source - Current file'))
vim.keymap.set('v', '<leader>X', ':lua<cr>', Opts('Source - Current selection'))
vim.keymap.set('n', '<leader><cr>', function()
    vim.o.hlsearch = not vim.o.hlsearch
end, Opts('Search - Toggle highlight'))

vim.keymap.set('n', '<leader>yp', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, Opts('Yank - File path'))

local tmux_session = function()
    if vim.env.TMUX then
        vim.fn.system('tmux split-window -v -l 20 tmux-session')
    else
        print('Not in a tmux session')
    end
end

vim.keymap.set('n', '<c-t>', tmux_session, Opts('Tmux - Switch session'))
