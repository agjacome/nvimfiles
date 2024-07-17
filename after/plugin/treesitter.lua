local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    return
end

-- textobjects config "inspired" by:
-- https://www.josean.com/posts/nvim-treesitter-and-textobjects
treesitter.setup({
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = false
    },
    indent = { enable = true },
    ensure_installed = {
        'gitignore',
        'json',
        'lua',
        'markdown',
        'vim',
        'yaml',
    },
    incremental_selection = {
        enable = true,
        keymaps = {
            init_selection = '<C-space>',
            node_incremental = '<C-space>',
            scope_incremental = false,
            node_decremental = '<bs>',
        },
    },
    textobjects = {
        select = {
            enable = true,
            lookahead = true,
            keymaps = {
                ['a='] = { query = '@assignment.outer', desc = 'Select outer part of an assignment' },
                ['i='] = { query = '@assignment.inner', desc = 'Select inner part of an assignment' },
                ['l='] = { query = '@assignment.lhs', desc = 'Select left hand side of an assignment' },
                ['r='] = { query = '@assignment.rhs', desc = 'Select right hand side of an assignment' },

                ['aa'] = { query = '@parameter.outer', desc = 'Select outer part of a parameter/argument' },
                ['ia'] = { query = '@parameter.inner', desc = 'Select inner part of a parameter/argument' },

                ['ai'] = { query = '@conditional.outer', desc = 'Select outer part of a conditional' },
                ['ii'] = { query = '@conditional.inner', desc = 'Select inner part of a conditional' },

                ['al'] = { query = '@loop.outer', desc = 'Select outer part of a loop' },
                ['il'] = { query = '@loop.inner', desc = 'Select inner part of a loop' },

                ['af'] = { query = '@call.outer', desc = 'Select outer part of a function call' },
                ['if'] = { query = '@call.inner', desc = 'Select inner part of a function call' },

                ['am'] = { query = '@function.outer', desc = 'Select outer part of a method/function definition' },
                ['im'] = { query = '@function.inner', desc = 'Select inner part of a method/function definition' },

                ['ac'] = { query = '@class.outer', desc = 'Select outer part of a class' },
                ['ic'] = { query = '@class.inner', desc = 'Select inner part of a class' },
            },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>na"] = "@parameter.inner",
            ["<leader>nm"] = "@function.outer",
          },
          swap_previous = {
            ["<leader>pa"] = "@parameter.inner",
            ["<leader>pm"] = "@function.outer",
          },
        },
        move = {
          enable = true,
          set_jumps = true,
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
        },
    }
})

local context_status_ok, context = pcall(require, 'treesitter-context')

if context_status_ok then
    vim.keymap.set('n', '<leader>c', context.toggle, { desc = 'Toggle context (TreeSitter)', remap = false, silent = true })
    vim.keymap.set('n', '[c', function() context.go_to_context(vim.v.count1) end, { desc = 'Previous context (TreeSitter)', remap = false, silent = true })
end

local repeat_status_ok, repeat_move = pcall(require, 'nvim-treesitter.textobjects.repeatable_move')

if repeat_status_ok then
    vim.keymap.set({ "n", "x", "o" }, ";", repeat_move.repeat_last_move,          { desc = 'Repeat last move (TreeSitter)', remap = false, silent = true })
    vim.keymap.set({ "n", "x", "o" }, "'", repeat_move.repeat_last_move_opposite, { desc = 'Repeat last move opposite (TreeSitter)', remap = false, silent = true })

    vim.keymap.set({ "n", "x", "o" }, "f", repeat_move.builtin_f, { desc = 'Find forward (TreeSitter)', remap = false, silent = true })
    vim.keymap.set({ "n", "x", "o" }, "F", repeat_move.builtin_F, { desc = 'Find backward (TreeSitter)', remap = false, silent = true })
    vim.keymap.set({ "n", "x", "o" }, "t", repeat_move.builtin_t, { desc = 'Till forward (TreeSitter)', remap = false, silent = true })
    vim.keymap.set({ "n", "x", "o" }, "T", repeat_move.builtin_T, { desc = 'Till backward (TreeSitter)', remap = false, silent = true })
end
