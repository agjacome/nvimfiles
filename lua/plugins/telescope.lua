return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "folke/trouble.nvim",
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" }
    },
    event = "VeryLazy",
    config = function()
        local telescope = require("telescope")

        local actions = require("telescope.actions")
        local trouble = require("trouble.sources.telescope")

        telescope.load_extension("fzf")

        telescope.setup({
            defaults = {
                path_display = { "shorten" },
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
                        ["<C-t>"] = trouble.open,
                        ["<C-T>"] = trouble.add,
                    },
                    n = {
                        ["<C-t>"] = trouble.open,
                        ["<C-T>"] = trouble.add,
                    }
                },
            },
            pickers = {
                colorscheme = {
                    enable_preview = true
                }
            }
        })

        local opts = function(desc)
            return { desc = desc, remap = false, silent = true }
        end

        local builtin = require("telescope.builtin")

        local find_files = function()
            builtin.find_files({
                hidden = true,
                no_ignore = true,
            })
        end


        vim.keymap.set("n", "<C-p>",     builtin.git_files,   opts("Fuzzy-find git files (Telescope)"))
        vim.keymap.set("n", "<leader>p", find_files,          opts("Fuzzy-find workspace files (Telescope)"))
        vim.keymap.set("n", "<leader>s", builtin.live_grep,   opts("Fuzzy-find by content (Telescope)"))
        vim.keymap.set("n", "<leader>S", builtin.grep_string, opts("Fuzzy-find text under cursor (Telescope)"))
        vim.keymap.set("n", "<leader>l", builtin.treesitter,  opts("Fuzzy-find by syntax (Telescope)"))

        vim.keymap.set("v", "<leader>s", "\"zy<cmd>exec 'Telescope live_grep default_text=' . escape(@z, ' ')<cr>", opts("Fuzzy-find selected text (Telescope)"))

        vim.keymap.set("n", "<leader>bb", builtin.buffers,                    opts("Fuzzy-find buffers (Telescope)"))
        vim.keymap.set("n", "<leader>bs", builtin.current_buffer_fuzzy_find,  opts("Fuzzy-find current buffer (Telescope)"))

        vim.keymap.set("n", "<leader>gb", builtin.git_bcommits,       opts("Git blame (Telescope)"))
        vim.keymap.set("n", "<leader>gr", builtin.git_bcommits_range, opts("Git blame range (Telescope)"))
        vim.keymap.set('n', '<leader>gc', builtin.git_commits,        opts('Git commits (Telescope)'))
        vim.keymap.set('n', '<leader>gB', builtin.git_branches,       opts('Git branches (Telescope)'))
        vim.keymap.set('n', '<leader>gt', builtin.git_stash,          opts('Git stashes (Telescope)'))
    end
}
