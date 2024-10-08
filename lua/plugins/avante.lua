return {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    build = "make",
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "stevearc/dressing.nvim",
        "nvim-lua/plenary.nvim",
        "muniftanjim/nui.nvim",
        "zbirenbaum/copilot.lua",
    },
    opts = {
        provider = "claude",
        auto_suggestions_provider = "copilot",
        behavior = {
            auto_suggestions = false,
            auto_set_highlight_group = false,
            auto_set_keymaps = true,
            auto_apply_diff_after_generation = false,
            support_paste_from_clipboard = false,
        },
        hints = {
            enabled = false
        },
        windows = {
            position = "right",
            wrap = true,
            width = 40,
            sidebar_header = {
                align = "center",
                rounded = false
            }
        }
    }
}
