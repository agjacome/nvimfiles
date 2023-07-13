local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    return
end

treesitter.setup({
    sync_install     = true,
    auto_install     = true,
    highlight        = {
        enable                            = true,
        additional_vim_regex_highlighting = false
    },
    indent           = {
        enable = true
    }
})

local context_status_ok, context = pcall(require, 'treesitter-context')

if not context_status_ok then
    return
end

vim.keymap.set('n', '[c', context.go_to_context, { desc = 'Go to context (TreeSitter)', remap = false, silent = true })
vim.keymap.set('n', '<leader>c', context.toggle, { desc = 'Toggle context (TreeSitter)', remap = false, silent = true })
