return {
    'nvim-telescope/telescope.nvim',
    dependencies = {
        'nvim-lua/plenary.nvim',
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
        'nvim-telescope/telescope-ui-select.nvim',
    },
    event = 'VeryLazy',
    config = function()
        local util = require('config.util')
        local telescope = require('telescope')
        local actions = require('telescope.actions')

        telescope.setup({
            defaults = {
                path_display = { 'shorten' },
                layout_config = {
                    width = 0.9,
                    height = 0.8,
                },
                borderchars = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
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
                    },
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true,
                },
            },
            extensions = {
                ['ui-select'] = {
                    require('telescope.themes').get_cursor({
                        borderchars = {
                            prompt = { '─', '│', ' ', '│', '┌', '┐', '│', '│' },
                            results = { '─', '│', '─', '│', '├', '┤', '┘', '└' },
                            preview = { '─', '│', '─', '│', '┌', '┐', '┘', '└' },
                        },
                    }),
                },
            },
        })

        telescope.load_extension('fzf')
        telescope.load_extension('ui-select')

        local builtin = require('telescope.builtin')

        local find_files = function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end

        vim.keymap.set('n', '<C-p>', function()
            builtin.git_files({ show_untracked = true })
        end, util.map_opts('Telescope - Git files'))
        vim.keymap.set('n', '<leader>p', find_files, util.map_opts('Telescope - Workspace files'))
        vim.keymap.set('n', '<leader>s', builtin.live_grep, util.map_opts('Telescope - Content'))
        vim.keymap.set('n', '<leader>S', builtin.grep_string, util.map_opts('Telescope - Word under cursor'))
        vim.keymap.set('v', '<leader>s', function()
            local text = table.concat(vim.fn.getregion(vim.fn.getpos('v'), vim.fn.getpos('.')), '\n')
            builtin.live_grep({ default_text = text })
        end, util.map_opts('Telescope - Selected text'))

        vim.keymap.set('n', '<leader>bb', builtin.buffers, util.map_opts('Telescope - Buffers'))
        vim.keymap.set('n', '<leader>sr', builtin.resume, util.map_opts('Telescope - Resume'))
        vim.keymap.set('n', '<leader>?', builtin.keymaps, util.map_opts('Telescope - Keymaps'))

        vim.keymap.set('n', '<leader>gb', builtin.git_bcommits, util.map_opts('Telescope - Git blame'))
        vim.keymap.set('v', '<leader>gr', builtin.git_bcommits_range, util.map_opts('Telescope - Git blame range'))
        vim.keymap.set('n', '<leader>gc', builtin.git_commits, util.map_opts('Telescope - Git commits'))
    end,
}
