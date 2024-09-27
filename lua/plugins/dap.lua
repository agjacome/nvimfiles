local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "thehamsta/nvim-dap-virtual-text",
            "nvim-telescope/telescope-dap.nvim",
        },
        event = "VeryLazy",
        config = function()
            local dap = require("dap")

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, opts("Toggle breakpoint (DAP)"))
            vim.keymap.set("n", "<leader>dc", dap.continue,          opts("Continue (DAP)"))
            vim.keymap.set("n", "<leader>di", dap.step_into,         opts("Step into (DAP)"))
            vim.keymap.set("n", "<leader>do", dap.step_over,         opts("Step over (DAP)"))
            vim.keymap.set("n", "<leader>dr", dap.repl.open,         opts("Open REPL (DAP)"))

        end
    },
    {
        "thehamsta/nvim-dap-virtual-text",
        event = "VeryLazy",
        opts = { }
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            local telescope = require("telescope")

            telescope.load_extension("dap")

            vim.keymap.set("n", "<leader>dv", telescope.extensions.dap.variables,        opts("List variables (DAP Telescope)"))
            vim.keymap.set("n", "<leader>dl", telescope.extensions.dap.list_breakpoints, opts("List breakpoints (DAP Telescope)"))
        end
    }
}
