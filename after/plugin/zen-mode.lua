local status_ok, zen_mode = pcall(require, 'zen-mode')

if not status_ok then
    return
end

local scrolloff_backup = vim.opt.scrolloff

zen_mode.setup({
    window = {
        backdrop = 1,
        width    = 90,
        options  = {
            list           = false,
            number         = false,
            relativenumber = false,
            signcolumn     = 'no',
        }
    },
    plugins = {
        options = {
            enabled = true,
            ruler = true,
            showcmd = false,
        },
        alacritty = {
            enabled = true,
            font    = "30",
        },
        tmux = { enabled = true },
        twilight = { enabled = false }
    },

    on_open = function()
        local twilight = require('twilight')
        twilight.setup({ context = 2 })
        twilight.enable()

        vim.opt.scrolloff = 100;
    end,

    on_close = function()
        local twilight = require('twilight')
        twilight.disable()

        vim.opt.scrolloff = scrolloff_backup
    end
})

vim.keymap.set('n', '<leader>z', zen_mode.toggle, { desc = 'Toggle ZenMode', remap = false, silent = true })


