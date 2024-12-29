return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        on_attach = function()
            local gitsigns = require("gitsigns")

            vim.keymap.set("n", "<leader>gg", gitsigns.toggle_signs, Opts("Gitsigns - Toggle"))
            vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, Opts("Gitsigns - Preview hunk"))

            vim.keymap.set("n", "<leader>gR", gitsigns.reset_hunk, Opts("Gitsigns - Reset hunk "))
            vim.keymap.set("v", "<leader>gR", function() gitsigns.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, Opts("Gitsigns - Reset hunk"))
        end
    }
}
