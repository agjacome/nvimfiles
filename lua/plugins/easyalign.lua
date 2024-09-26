return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>a", ":LiveEasyAlign<cr>", { remap = false, silent = true, desc = "Start EasyAlign" })
        vim.keymap.set("v", "<cr>",      ":LiveEasyAlign<cr>", { remap = false, silent = true, desc = "Start EasyAlign" })
    end
}
