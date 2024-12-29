return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, Opts("Undotree - Toggle"))
    end
}
