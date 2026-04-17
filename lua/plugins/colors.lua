return {
    {
        'mcchrish/zenbones.nvim',
        dependencies = {
            'rktjmp/lush.nvim',
        },
        lazy = false,
        config = function()
            local util = require('config.util')

            vim.g.zenbones = {
                lightness = 'dim',
                italic_comments = false,
            }

            vim.o.background = 'dark'
            vim.cmd.colorscheme('zenbones')

            local toggle_background = function()
                vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
            end

            vim.keymap.set('n', '<f12>', toggle_background, util.map_opts('Colors - Toggle dark/light'))
        end,
    },
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        opts = {
            options = {
                component_separators = '|',
                section_separators = '',
                icons_enabled = false,
                theme = 'zenbones',
            },
            sections = {
                lualine_c = {
                    { 'filename', path = 1 },
                },
            },
        },
    },
    {
        'j-hui/fidget.nvim',
        event = 'VeryLazy',
        opts = {
            notification = {
                window = { winblend = 0 },
            },
        },
    },
}
