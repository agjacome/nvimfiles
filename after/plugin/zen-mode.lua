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
        alacritty = {
            enabled = true,
            font    = 24,
        },
        tmux = {
            enabled = true,
            font    = 24,
        }
    }
})

vim.keymap.set('n', '<leader>z', zen_mode.toggle, { desc = 'Toggle ZenMode', remap = false, silent = true })
