return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "main",
        lazy = false,
        build = ":TSUpdate",
        config = function()
            local max_filesize = 100 * 1024 -- 100KB

            vim.api.nvim_create_autocmd("FileType", {
                callback = function(args)
                    local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
                    if ok and stats and stats.size > max_filesize then return end

                    local ft = vim.bo[args.buf].filetype
                    local lang = vim.treesitter.language.get_lang(ft) or ft

                    if not vim.treesitter.language.add(lang) then
                        local available = vim.g.ts_available
                            or require("nvim-treesitter").get_available()
                        if not vim.g.ts_available then
                            vim.g.ts_available = available
                        end
                        if vim.tbl_contains(available, lang) then
                            require("nvim-treesitter").install(lang)
                        end
                    end

                    if not vim.treesitter.language.add(lang) then return end
                    vim.treesitter.start(args.buf, lang)
                    vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
                end,
            })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        branch = "main",
        event = "VeryLazy",
        config = function()
            local select_fn = require("nvim-treesitter-textobjects.select").select_textobject
            local move = require("nvim-treesitter-textobjects.move")
            local swap = require("nvim-treesitter-textobjects.swap")

            -- select keymaps
            local select_maps = {
                ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
                ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
                ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
                ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

                ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
                ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

                ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
                ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

                ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
                ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

                ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
                ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

                ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
                ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

                ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
                ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            }

            for key, cfg in pairs(select_maps) do
                vim.keymap.set({ "x", "o" }, key, function()
                    select_fn(cfg.query, "textobjects")
                end, { desc = cfg.desc })
            end

            -- move keymaps
            local move_maps = {
                goto_next_start = {
                    ["]f"] = { query = "@call.outer", desc = "Next function call start" },
                    ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
                    ["]c"] = { query = "@class.outer", desc = "Next class start" },
                    ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
                    ["]l"] = { query = "@loop.outer", desc = "Next loop start" },
                },
                goto_next_end = {
                    ["]F"] = { query = "@call.outer", desc = "Next function call end" },
                    ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
                    ["]C"] = { query = "@class.outer", desc = "Next class end" },
                    ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
                    ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
                },
                goto_previous_start = {
                    ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
                    ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
                    ["[c"] = { query = "@class.outer", desc = "Prev class start" },
                    ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
                    ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
                },
                goto_previous_end = {
                    ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
                    ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
                    ["[C"] = { query = "@class.outer", desc = "Prev class end" },
                    ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
                    ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
                },
            }

            for fn_name, mappings in pairs(move_maps) do
                for key, cfg in pairs(mappings) do
                    vim.keymap.set({ "n", "x", "o" }, key, function()
                        move[fn_name](cfg.query, "textobjects")
                    end, { desc = cfg.desc })
                end
            end

            -- swap keymaps
            vim.keymap.set("n", "<leader>na", function() swap.swap_next("@parameter.inner", "textobjects") end, { desc = "Swap next parameter" })
            vim.keymap.set("n", "<leader>nm", function() swap.swap_next("@function.outer", "textobjects") end, { desc = "Swap next function" })
            vim.keymap.set("n", "<leader>pa", function() swap.swap_previous("@parameter.inner", "textobjects") end, { desc = "Swap prev parameter" })
            vim.keymap.set("n", "<leader>pm", function() swap.swap_previous("@function.outer", "textobjects") end, { desc = "Swap prev function" })
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        event = "VeryLazy",
        config = function()
            local Opts = require('agjacome.opts')
            local context = require("treesitter-context")

            context.setup({
                max_lines = 3,
            })

            vim.keymap.set("n", "<leader>c", context.toggle, Opts("Treesitter - Toggle context"))
            vim.keymap.set("n", "[cc", function() context.go_to_context(vim.v.count1) end, Opts("Treesitter - Go to context"))
        end,
    },
}
