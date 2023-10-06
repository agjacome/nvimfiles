local status_ok, telescope = pcall(require, 'telescope')

if not status_ok then
    return
end

telescope.load_extension('dap')
telescope.load_extension('fzf')
telescope.load_extension('media_files')

local actions = require('telescope.actions')

telescope.setup({
    defaults = {
        path_display = { 'smart' },
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case',
            '--hidden',
        },
        mappings = {
            i = {
                ['<C-j>'] = actions.cycle_history_next,
                ['<C-k>'] = actions.cycle_history_prev,
                ['<C-s>'] = actions.cycle_previewers_next,
                ['<C-r>'] = actions.cycle_previewers_prev,
            }
        },
    }
})

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

local builtin = require('telescope.builtin')

local find_files = function()
    builtin.find_files({
        hidden = true,
        no_ignore = true,
    })
end

vim.keymap.set('n', '<C-p>',     builtin.git_files,  opts('Fuzzy-find git files (Telescope)'))
vim.keymap.set('n', '<leader>p', find_files,         opts('Fuzzy-find workspace files (Telescope)'))
vim.keymap.set('n', '<leader>s', builtin.live_grep,  opts('Fuzzy-find by content (Telescope)'))
vim.keymap.set('n', '<leader>l', builtin.treesitter, opts('Fuzzy-find by syntax (Telescope)'))

vim.keymap.set('n', '<leader>bb', builtin.buffers,                    opts('Fuzzy-find buffers (Telescope)'))
vim.keymap.set('n', '<leader>bs', builtin.current_buffer_fuzzy_find,  opts('Fuzzy-find current buffer (Telescope)'))

vim.keymap.set('n', '<leader>gb', builtin.git_bcommits,       opts('Git blame (Telescope)'))
vim.keymap.set('n', '<leader>gr', builtin.git_bcommits_range, opts('Git blame range (Telescope)'))
