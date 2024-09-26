return {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    opts = {
        on_attach = function(buffer)
            local gitsigns = require("gitsigns")

            local opts = function(desc)
                return { buffer = buffer, desc = desc, remap = false, silent = true }
            end

            vim.keymap.set("n", "<leader>gg", gitsigns.toggle_signs, opts("Toggle Gitsigns"))
            vim.keymap.set("n", "<leader>gp", gitsigns.preview_hunk, opts("Preview git hunk (Gitsigns)"))

            vim.keymap.set("n", "<leader>gR", gitsigns.reset_hunk, opts("Reset git hunk (Gitsigns)"))
            vim.keymap.set("v", "<leader>gR", function() gitsigns.reset_hunk({vim.fn.line("."), vim.fn.line("v")}) end, opts("Reset git hunk (Gitsigns)"))
        end
    }
}
