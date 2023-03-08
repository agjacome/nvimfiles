vim.g.mapleader      = ','
vim.g.maplocalleader = ';'

local nore   = { remap = false }
local silent = { remap = false, silent = true }

-- disable stuff
vim.keymap.set('n', 'q:',      '<nop>', nore)
vim.keymap.set('n', 'q/',      '<nop>', nore)
vim.keymap.set('n', 'q?',      '<nop>', nore)
vim.keymap.set('n', 'Q',       '<nop>', nore)
vim.keymap.set('n', '<left>',  '<nop>', nore)
vim.keymap.set('n', '<right>', '<nop>', nore)
vim.keymap.set('n', '<up>',    '<nop>', nore)
vim.keymap.set('n', '<down>',  '<nop>', nore)

-- navigation
vim.keymap.set('n', '<c-h>',   '<c-w>h',         silent)
vim.keymap.set('n', '<c-j>',   '<c-w>j',         silent)
vim.keymap.set('n', '<c-k>',   '<c-w>k',         silent)
vim.keymap.set('n', '<c-l>',   '<c-w>l',         silent)
vim.keymap.set('n', '<tab>',   ':bnext<cr>',     silent)
vim.keymap.set('n', '<s-tab>', ':bprevious<cr>', silent)

-- split window
vim.keymap.set('n', '<leader>H', ':leftabove vnew<cr>',  silent)
vim.keymap.set('n', '<leader>J', ':leftabove new<cr>',   silent)
vim.keymap.set('n', '<leader>K', ':rightbelow new<cr>',  silent)
vim.keymap.set('n', '<leader>L', ':rightbelow vnew<cr>', silent)

-- toggles
function toggle_hlsearch()
    vim.o.hlsearch = not vim.o.hlsearch
end

function toggle_relnum()
    vim.o.relativenumber = not vim.o.relativenumber
end

vim.keymap.set('n', '<cr>', toggle_hlsearch, silent)
vim.keymap.set('n', '<f6>', toggle_relnum,   silent)

-- expansions
vim.keymap.set('c', '%%',        '<c-r>=expand("%:p:h") . "/"<cr>',   nore)
vim.keymap.set('n', '<leader>D', '"=strftime("%Y/%m/%d %H:%M")<cr>p', silent)
