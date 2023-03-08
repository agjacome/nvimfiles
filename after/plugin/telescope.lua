local status_ok, telescope = pcall(require, 'telescope.builtin')

if not status_ok then
    return
end

function telescope_grep()
    telescope.grep_string({ search = vim.fn.input('grep > ') })
end

vim.keymap.set('n', '<C-p>',      telescope.git_files,  { remap = false, silent = true })
vim.keymap.set('n', '<leader>p',  telescope.find_files, { remap = false, silent = true })
vim.keymap.set('n', '<leader>vh', telescope.help_tags,  { remap = false, silent = true })
vim.keymap.set('n', '<leader>s',  telescope_grep,       { remap = false, silent = true })
