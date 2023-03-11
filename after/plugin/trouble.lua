local status_ok, trouble = pcall(require, 'trouble')

if not status_ok then
    return
end

trouble.setup({ icons = false })

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',                      opts('Toggle Trouble'))
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', opts('Show document diagnostics (Trouble)'))
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',             opts('Show quickfix window (Trouble)'))

