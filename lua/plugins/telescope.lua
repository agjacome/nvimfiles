return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    event = "VeryLazy",
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.load_extension("fzf")

        telescope.setup({
            defaults = require('telescope.themes').get_ivy({
                path_display = { "shorten" },
                layout_config = {
                    height = 40,
                },
                borderchars = {
                    prompt = { "─", "│", " ", "│", "┌", "┐", "│", "│" },
                    results = { "─", "│", "─", "│", "├", "┤", "┘", "└" },
                    preview = { "─", "│", "─", "│", "┌", "┐", "┘", "└" },
                },
                vimgrep_arguments = {
                    "rg",
                    "--color=never",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--hidden",
                },
                mappings = {
                    i = {
                        ["<C-j>"] = actions.cycle_history_next,
                        ["<C-k>"] = actions.cycle_history_prev,
                        ["<C-s>"] = actions.cycle_previewers_next,
                        ["<C-r>"] = actions.cycle_previewers_prev,
                    },
                },
            }),
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            }
        })

        local builtin = require("telescope.builtin")

        local find_files = function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end

        vim.keymap.set("n", "<C-p>",     builtin.git_files,   Opts("Telescope - Git files"))
        vim.keymap.set("n", "<leader>p", find_files,          Opts("Telescope - Workspace files"))
        vim.keymap.set("n", "<leader>s", builtin.live_grep,   Opts("Telescope - Content"))
        vim.keymap.set("n", "<leader>S", builtin.grep_string, Opts("Telescope - Word under cursor"))
        vim.keymap.set("v", "<leader>s", "\"zy<cmd>exec 'Telescope live_grep default_text=' . escape(@z, ' ')<cr>", Opts("Telescope - Selected text"))

        vim.keymap.set("n", "<leader>bb", builtin.buffers, Opts("Telescope - Buffers"))

        vim.keymap.set("n", "<leader>gb", builtin.git_bcommits,       Opts("Telescope - Git blame"))
        vim.keymap.set("v", "<leader>gr", builtin.git_bcommits_range, Opts("Telescope - Git blame range"))
        vim.keymap.set('n', '<leader>gc', builtin.git_commits,        Opts('Telescope - Git commits'))
    end
}
