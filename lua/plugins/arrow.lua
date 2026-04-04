return {
    'otavioschwanck/arrow.nvim',
    event = 'VeryLazy',
    opts = {
        show_icons = false,
        leader_key = '<leader>hl',
        save_key = 'git_root',
        index_keys = '123456789',
        window = {
            border = 'single',
        },
    },
    config = function(_, opts)
        local util = require('config.util')
        require('arrow').setup(opts)

        local persist = require('arrow.persist')

        vim.keymap.set('n', '<leader>ha', persist.toggle, util.map_opts('Arrow - Toggle file'))
        vim.keymap.set('n', '<leader>hj', persist.next, util.map_opts('Arrow - Next file'))
        vim.keymap.set('n', '<leader>hk', persist.previous, util.map_opts('Arrow - Previous file'))

        for i = 1, 9 do
            vim.keymap.set('n', '<leader>' .. i, function()
                persist.go_to(i)
            end, util.map_opts('Arrow - Goto ' .. i))
        end
    end,
}
