local group   = vim.api.nvim_create_augroup('agjacome', {})
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position when reopening a file
autocmd('BufReadPost', {
    group   = group,
    pattern = '*',
    command = [[if line("'\"") > 0 && line("'\"") <= line("$") | exe "normal g`\"" | endif]]
})

-- Remove trailing whitespaces on save
autocmd('BufWritePre', {
    group   = group,
    pattern = '*',
    command = [[%s/\s\+$//e]]
})

-- Highlight yanked text
autocmd('TextYankPost', {
    group    = group,
    pattern  = '*',
    callback = function()
        vim.highlight.on_yank({
            higroup = 'IncSearch',
            timeout = 150
        })
    end
})

-- Autorun chezmoi apply
autocmd('BufWritePost', {
    group   = group,
    pattern = vim.env.HOME .. '/.local/share/chezmoi/**',
    command = [[!chezmoi apply --source-path %]]
})
