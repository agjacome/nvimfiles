local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.g.mapleader      = ' '
vim.g.maplocalleader = ' '

-- disable stuff
vim.keymap.set('n', 'q:',      '<nop>', opts('Disabled'))
vim.keymap.set('n', 'q/',      '<nop>', opts('Disabled'))
vim.keymap.set('n', 'q?',      '<nop>', opts('Disabled'))
vim.keymap.set('n', 'Q',       '<nop>', opts('Disabled'))
vim.keymap.set('n', '<left>',  '<nop>', opts('Disabled'))
vim.keymap.set('n', '<right>', '<nop>', opts('Disabled'))
vim.keymap.set('n', '<up>',    '<nop>', opts('Disabled'))
vim.keymap.set('n', '<down>',  '<nop>', opts('Disabled'))

-- navigation
vim.keymap.set('n', '<c-h>',   '<c-w>h',         opts('Move to Left window'))
vim.keymap.set('n', '<c-j>',   '<c-w>j',         opts('Move to Down window'))
vim.keymap.set('n', '<c-k>',   '<c-w>k',         opts('Move to Up window'))
vim.keymap.set('n', '<c-l>',   '<c-w>l',         opts('Move to Right window'))
vim.keymap.set('n', '<tab>',   ':bnext<cr>',     opts('Move to Next buffer'))
vim.keymap.set('n', '<s-tab>', ':bprevious<cr>', opts('Move to Previous buffer'))

-- quickfix navigation
vim.api.nvim_create_autocmd('BufReadPost', {
    group   = vim.api.nvim_create_augroup('quickfix', {}),
    pattern = 'quickfix',
    command = 'nnoremap <buffer> <cr> <cr>'
})

-- toggles
local toggle_hlsearch = function()
    vim.o.hlsearch = not vim.o.hlsearch
end

local toggle_relnum = function()
    vim.o.relativenumber = not vim.o.relativenumber
end

vim.keymap.set('n', '<cr>', toggle_hlsearch, opts('Toggle search Highlight'))
vim.keymap.set('n', '<f6>', toggle_relnum,   opts('Toggle Relative line number'))

-- expansions
vim.keymap.set('c', '%%',        '<c-r>=expand("%:p:h") . "/"<cr>',   opts('Expand to current directory'))
vim.keymap.set('n', '<leader>D', '"=strftime("%Y-%m-%d %H:%M")<cr>p', opts('Insert current DateTime'))

-- diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts('Show line diagnostics'))
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev,  opts('Go to previous diagnostic'))
vim.keymap.set('n', ']d', vim.diagnostic.goto_next,  opts('Go to next diagnostic'))

-- tmux stuff
local tmux_session = function()
    if vim.env.TMUX then
        vim.fn.system('tmux split-window -v -l 20 "tmux-session"')
    else
        print('Not in a tmux session')
    end
end

vim.keymap.set('n', '<c-t>', tmux_session, opts('Open tmux session'))
