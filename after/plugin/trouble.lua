local status_ok, trouble = pcall(require, 'trouble')

if not status_ok then
    return
end

trouble.setup()

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              opts('Diagnostics (Trouble)'))
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', opts('Buffer diagnostics (Trouble)'))
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                   opts('Quickfix list (Trouble)'))
