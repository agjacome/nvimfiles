local status_ok, trouble = pcall(require, 'trouble')

if not status_ok then
    return
end

trouble.setup()

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>',              opts('Diagnostics (Trouble)'))
vim.keymap.set('n', '<leader>xd', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', opts('Buffer diagnostics (Trouble)'))
vim.keymap.set('n', '<leader>xq', '<cmd>Trouble qflist toggle<cr>',                   opts('Quickfix list (Trouble)'))

local telescope_ok, telescope = pcall(require, "telescope")

if not telescope_ok then
    return
end

local open_with_trouble = require("trouble.sources.telescope").open
local add_to_trouble =  require("trouble.sources.telescope").add

telescope.setup({
    defaults = {
        mappings = {
            i = {
                ["<c-t>"] = open_with_trouble,
                ["<c-T>"] = add_to_trouble
            },
            n = {
                ["<c-t>"] = open_with_trouble,
                ["<c-T>"] = add_to_trouble
            },
        },
    },
})
