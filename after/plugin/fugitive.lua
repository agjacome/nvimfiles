vim.keymap.set('n', '<leader>gs', vim.cmd.Git, { remap = false })

local fugitive_group = vim.api.nvim_create_augroup('Fugitive', {})

vim.api.nvim_create_autocmd('BufWinEnter', {
    group    = fugitive_group,
    pattern  = '*',
    callback = function()
        if vim.bo.ft ~= 'fugitive' then
            return
        end

        local buffer = vim.api.nvim_get_current_buf()

        local opts = function(desc)
            return { buffer = buffer, desc = desc, remap = false, silent = true }
        end

        local git_push = function() vim.cmd.Git('push') end
        local git_pull = function() vim.cmd.Git('pull --rebase --autostash') end
        vim.keymap.set('n', '<leader>P', git_push, opts('Git push (Fugitive)'))
        vim.keymap.set('n', '<leader>p', git_pull, opts('Git pull (Fugitive)'))

        local telescope = require('telescope.builtin')
        vim.keymap.set('n', '<leader>gb',  telescope.git_branches, opts('Show Git branches (Telescope)'))
        vim.keymap.set('n', '<leader>gc',  telescope.git_commits,  opts('Show Git commits (Telescope)'))
        vim.keymap.set('n', '<leader>gst', telescope.git_stash,    opts('Show Git stashes (Telescope)'))
    end
})
