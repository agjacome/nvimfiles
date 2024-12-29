return {
    "junegunn/vim-easy-align",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("v", "<cr>",  ":LiveEasyAlign<cr>", Opts("EasyAlign - Start"))
    end
}
