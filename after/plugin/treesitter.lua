local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    return
end

treesitter.setup({
    ensure_installed = { 'help', 'lua', 'query' },
    sync_install     = true,
    auto_install     = true,
    highlight        = {
        enable                            = true,
        additional_vim_regex_highlighting = false
    },
    indent = {
        enable  = true
    }
})

vim.keymap.set('n', '<leader>c', vim.cmd.TSContextToggle, { desc = 'Toggle context (TreeSitter)', remap = false, silent = true })
