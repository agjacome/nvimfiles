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

lsp_zero.on_attach(function(_, buffer)
    local opts = function(desc)
        return { buffer = buffer, silent = true, desc = desc }
    end

    lsp_zero.default_keymaps(opts)
    vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opts('Format current buffer (LSP)'))

    vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>',      opts('Go to definition (LSP)'))
    vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<cr>', opts('Go to type definition (LSP)'))
    vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>',  opts('Go to implementation (LSP)'))
    vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>',       opts('Find references (LSP)'))
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

local lsp_config = require('lspconfig')

lsp_config.denols.setup({
    root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
})

lsp_config.tsserver.setup({
    root_dir = lsp_config.util.root_pattern("package.json"),
    single_file_support = false
})
