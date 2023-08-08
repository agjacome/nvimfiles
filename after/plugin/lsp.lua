local lsp_status_ok, lsp_zero = pcall(require, 'lsp-zero')

if not lsp_status_ok then
    return
end

lsp_zero.preset({
    name                = 'recommended',
    set_lsp_keymaps     = true,
    manage_nvim_cmp     = true,
    suggest_lsp_servers = false,
})

local opts = function(buffer)
    return function(desc)
        return { buffer = buffer, silent = true, desc = desc }
    end
end

local format = function(buffer)
    return function()
        vim.lsp.buf.format({ async = true, bufnr = buffer })
    end
end

lsp_zero.on_attach(function(client, buffer)
    local options = opts(buffer)

    lsp_zero.default_keymaps(options(''))

    if client.supports_method('textDocument/formatting') then
        vim.keymap.set({ 'n', 'x' }, '<F3>', format(buffer), options('Format current buffer (LSP)'))
    end

    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>',      options('Go to definition (LSP)'))
    vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<cr>', options('Go to type definition (LSP)'))
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>',  options('Go to implementation (LSP)'))
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>',       options('Find references (LSP)'))
end)

local neodev_status_ok, neodev = pcall(require, 'neodev')
if neodev_status_ok then
    neodev.setup()
end

lsp_zero.setup()

local cmp        = require('cmp')
local cmp_action = lsp_zero.cmp_action()

cmp.setup({
    sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
    },
    mapping = {
        ['<CR>']      = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-j>']     = cmp_action.luasnip_jump_forward(),
        ['<C-k>']     = cmp_action.luasnip_jump_backward(),
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
    }
})
