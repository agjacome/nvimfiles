local telescope = require('telescope')

telescope.load_extension('dap')
telescope.load_extension('fzf')

local actions = require('telescope.actions')
local mappings = {
    i = {
        ['<C-j>'] = actions.cycle_history_next,
        ['<C-k>'] = actions.cycle_history_prev,
        ['<C-s>'] = actions.cycle_previewers_next,
        ['<C-r>'] = actions.cycle_previewers_prev,
    },
    n = { }
}

local trouble_ok, _ = pcall(require, 'trouble')
if trouble_ok then
    local trouble = require('trouble.sources.telescope')

    mappings['i']['<C-t>'] = trouble.open
    mappings['n']['<C-t>'] = trouble.open

    mappings['i']['<C-T>'] = trouble.add
    mappings['n']['<C-T>'] = trouble.add
end

telescope.setup({
    defaults = {
        path_display = { 'shorten' },
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
        mappings = mappings,
    },
    pickers = {
        colorscheme = {
            enable_preview = true
        }
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
