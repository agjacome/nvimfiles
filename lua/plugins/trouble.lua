return {
    "folke/trouble.nvim",
    event = "VeryLazy",
    config = function()
        local trouble = require("trouble")

        trouble.setup({
            icons = {
              folder_closed = "",
              folder_open = "",
            }
        })

        local opts = function(desc)
            return { desc = desc, remap = false, silent = true }
        end

        vim.keymap.set("n", "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",              opts("Diagnostics (Trouble)"))
        vim.keymap.set("n", "<leader>xd", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", opts("Buffer diagnostics (Trouble)"))
        vim.keymap.set("n", "<leader>xq", "<cmd>Trouble qflist toggle<cr>",                   opts("Quickfix list (Trouble)"))
    end
}
