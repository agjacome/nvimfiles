local telescope = require('telescope.builtin')

function telescope_grep()
    telescope.grep_string({ search = vim.fn.input('grep > ') })
end

vim.keymap.set('n', '<C-p>',      telescope.git_files,  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>p',  telescope.find_files, { noremap = true, silent = true })
vim.keymap.set('n', '<leader>vh', telescope.help_tags,  { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ps', telescope_grep,       { noremap = true, silent = true })
