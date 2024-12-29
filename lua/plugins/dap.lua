return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "nvim-telescope/telescope-dap.nvim",
        },
        event = "VeryLazy",
        config = function()
            local dap = require("dap")

            vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, Opts("DAP - Toggle breakpoint"))
            vim.keymap.set("n", "<leader>dr", dap.repl.open, Opts("DAP - REPL"))
            vim.keymap.set("n", "<F5>", dap.step_into, Opts("DAP - Step into"))
            vim.keymap.set("n", "<F6>", dap.step_over, Opts("DAP - Step over"))
            vim.keymap.set("n", "<F7>", dap.continue, Opts("DAP - Continue"))
        end
    },
    {
        "nvim-telescope/telescope-dap.nvim",
        dependencies = {
            "nvim-telescope/telescope.nvim",
        },
        event = "VeryLazy",
        config = function()
            require("telescope").load_extension("dap")
        end
    }
}
