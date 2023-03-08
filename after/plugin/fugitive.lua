vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { remap = false })

local fugitive_group = vim.api.nvim_create_augroup('Fugitive', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group    = fugitive_group,
    pattern  = '*',
    callback = function()
        if vim.bo.ft ~= 'fugitive' then
            return
        end

        local buffer_num = vim.api.nvim_get_current_buf()
        local map_opts   = { buffer = buffer_num, remap = false }

        function git_push() vim.cmd.Git('push') end
        function git_pull() vim.cmd.Git('pull --rebase --autostash') end
        vim.keymap.set('n', '<leader>P', git_push, map_opts)
        vim.keymap.set('n', '<leader>p', git_pull, map_opts)

        local status_ok, telescope = pcall(require, 'telescope.builtin')
        if status_ok then
            vim.keymap.set('n', '<leader>gb',  telescope.git_branches, map_opts)
            vim.keymap.set('n', '<leader>gc',  telescope.git_commits,  map_opts)
            vim.keymap.set('n', '<leader>gst', telescope.git_stash,    map_opts)
        end
    end
})
