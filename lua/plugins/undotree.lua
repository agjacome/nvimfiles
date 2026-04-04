return {
    "mbbill/undotree",
    event = "VeryLazy",
    config = function()
        local Opts = require('agjacome.opts')
        vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, Opts("Undotree - Toggle"))
    end
}
