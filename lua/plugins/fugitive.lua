return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, { remap = false })

        vim.api.nvim_create_autocmd("BufWinEnter", {
            group    = vim.api.nvim_create_augroup("Fugitive", {}),
            pattern  = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local buffer = vim.api.nvim_get_current_buf()

                local opts = function(desc)
                    return { buffer = buffer, desc = desc, remap = false, silent = true }
                end

                local git_pull = function() vim.cmd.Git("pull --rebase --autostash") end
                vim.keymap.set("n", "<leader>p", git_pull, opts("Git pull (Fugitive)"))

                local git_push = function() vim.cmd.Git("push") end
                vim.keymap.set("n", "<leader>P", git_push, opts("Git push (Fugitive)"))
            end
        })
    end
}
