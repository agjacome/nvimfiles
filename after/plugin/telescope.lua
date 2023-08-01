local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    return
end

telescope.load_extension('fzf')
telescope.load_extension('media_files')

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

local builtin = require('telescope.builtin')

local telescope_grep = function()
    builtin.live_grep({
        hidden = true,
        no_ignore = true
    })
end

local find_files = function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end

local media_files = function()
    telescope.extensions.media_files.media_files()
end

vim.keymap.set('n', '<C-p>',     builtin.git_files,  opts('Fuzzy-find git files (Telescope)'))
vim.keymap.set('n', '<leader>p', find_files,           opts('Fuzzy-find workspace files (Telescope)'))
vim.keymap.set('n', '<leader>s', telescope_grep,       opts('Fuzzy-find by content (Telescope)'))
vim.keymap.set('n', '<leader>l', builtin.treesitter, opts('Fuzzy-find keymap (Telescope)'))

vim.keymap.set('n', '<leader>h', builtin.help_tags, opts('Fuzzy-find help_tags (Telescope)'))
vim.keymap.set('n', '<leader>k', builtin.keymaps,   opts('Fuzzy-find keymap (Telescope)'))

vim.keymap.set('n', '<leader>m', media_files, opts('Fuzzy-find media files (Telescope)'))
