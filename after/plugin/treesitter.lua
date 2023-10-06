local status_ok, treesitter = pcall(require, 'nvim-treesitter.configs')

if not status_ok then
    return
end

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
})

local context_status_ok, context = pcall(require, 'treesitter-context')

if not context_status_ok then
    return
end

vim.keymap.set('n', '[c', context.go_to_context, { desc = 'Go to context (TreeSitter)', remap = false, silent = true })
vim.keymap.set('n', '<leader>c', context.toggle, { desc = 'Toggle context (TreeSitter)', remap = false, silent = true })
