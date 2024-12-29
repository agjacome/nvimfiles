return {
    "tpope/vim-fugitive",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>gs", vim.cmd.Git, Opts("Fugitive - Open"))

        vim.api.nvim_create_autocmd("BufWinEnter", {
            group    = vim.api.nvim_create_augroup("Fugitive", {}),
            pattern  = "*",
            callback = function()
                if vim.bo.ft ~= "fugitive" then
                    return
                end

                local buffer = vim.api.nvim_get_current_buf()

                vim.keymap.set("n", "<leader>p", function() vim.cmd.Git("pull --rebase --autostash") end, Opts("Fugitive - Pull", buffer))
                vim.keymap.set("n", "<leader>P", function() vim.cmd.Git("push") end, Opts("Fugitive - Push", buffer))
            end
        })
    end
}
