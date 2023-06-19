local status_ok, prettier = pcall(require, 'prettier')

local bin =
    vim.fn.executable('prettierd') == 1 and 'prettierd'
    or vim.fn.executable('prettier') == 1 and 'prettier'
    or nil

if not status_ok or not bin then
    return
end

prettier.setup({
    bin = bin,
    filetypes = {
        'css',
        'graphql',
        'html',
        'javascript',
        'javascriptreact',
        'json',
        'less',
        'markdown',
        'scss',
        'typescript',
        'typescriptreact',
        'yaml',
    }
})
