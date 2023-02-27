local telescope = require('telescope.builtin')

vim.keymap.set('n', '<C-p>',      telescope.git_files, {})
vim.keymap.set('n', '<leader>p',  telescope.find_files, {})
vim.keymap.set('n', '<leader>ps', function()
    telescope.grep_string({ search = vim.fn.input('grep > ') })
end)
vim.keymap.set('n', '<leader>vh', telescope.help_tags, {})
