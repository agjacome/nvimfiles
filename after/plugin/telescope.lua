local status_ok, telescope = pcall(require, 'telescope.builtin')

if not status_ok then
    return
end

local telescope_grep = function()
    telescope.grep_string({ search = vim.fn.input('grep: ') })
end

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<C-p>',      telescope.git_files,  opts('Fuzzy-find git files (Telescope)'))
vim.keymap.set('n', '<leader>p',  telescope.find_files, opts('Fuzzy-find workspace files (Telescope)'))
vim.keymap.set('n', '<leader>vh', telescope.help_tags,  opts('Fuzzy-find help_tags (Telescope)'))
vim.keymap.set('n', '<leader>s',  telescope_grep,       opts('Fuzzy-find by content (Telescope)'))
