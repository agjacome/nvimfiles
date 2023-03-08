local agjacome_group = vim.api.nvim_create_augroup('agjacome', {})

-- Restore cursor position when reopening a file
vim.api.nvim_create_autocmd('BufReadPost', {
    group   = agjacome_group,
    pattern = '*',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]]
})
