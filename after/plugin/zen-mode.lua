local status_ok, zen_mode = pcall(require, 'zen-mode')

if not status_ok then
    return
end

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
    }
})

local twilight_ok, twilight = pcall(require, 'twilight')

if twilight_ok then
    twilight.setup({ context = 2 })
end

vim.keymap.set('n', '<leader>z', zen_mode.toggle, { desc = 'Toggle ZenMode', remap = false, silent = true })


