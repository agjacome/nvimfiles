local status_ok, trouble = pcall(require, 'trouble')

if not status_ok then
    return
end

trouble.setup({ icons = false })

local silent = { remap = false, silent = true }

vim.keymap.set('n', '<leader>xx', '<cmd>TroubleToggle<cr>',                      silent)
vim.keymap.set('n', '<leader>xd', '<cmd>TroubleToggle document_diagnostics<cr>', silent)
vim.keymap.set('n', '<leader>xq', '<cmd>TroubleToggle quickfix<cr>',             silent)

