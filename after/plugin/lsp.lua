local neodev = require('neodev')
neodev.setup({
    override = function(_, library)
        library.enabled = true
        library.plugins = true
    end
})

local mason = require('mason')
mason.setup({})

local default_capabilities = function(server)
    require('lspconfig')[server].setup({
        capabilities = require('cmp_nvim_lsp').default_capabilities()
    })
end

require('mason-lspconfig').setup({
    ensure_installed = {},
    handlers = { default_capabilities }
})

local cmp = require('cmp')
cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end
    },
    mapping = cmp.mapping.preset.insert({
        ['<CR>']      = cmp.mapping.confirm({ select = false }),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-b>']     = cmp.mapping.scroll_docs(-4),
        ['<C-f>']     = cmp.mapping.scroll_docs(4),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }
    }, {
        { name = 'buffer' },
    }),
})

vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions',
    callback = function(event)
        local opt = function(desc)
            return { buffer = event.buffer, silent = true, desc = desc }
        end

        vim.keymap.set('n', 'K', '<cmd>lua vim.lsp.buf.hover()<cr>', opt(''))

        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', opt('Go to definition (LSP)'))
        vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<cr>', opt('Go to type definition (LSP)'))
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', opt('Go to implementation (LSP)'))
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_incoming_calls<cr>', opt('Go to incoming calls (LSP)'))
        vim.keymap.set('n', 'gO', '<cmd>Telescope lsp_outgoing_calls<cr>', opt('Go to outgoing calls (LSP)'))
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', opt('Go to references (LSP)'))

        vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>', opt('Rename symbol (LSP)'))
        vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>', opt('Code action (LSP)'))

        vim.keymap.set('n', '<leader>l', '<cmd>Telescope lsp_document_symbols<cr>', opt('List symbols (LSP)'))
        vim.keymap.set('n', '<leader>L', '<cmd>Telescope lsp_workspace_symbols<cr>', opt('List workspace symbols (LSP)'))

        vim.keymap.set({ 'n', 'x' }, '<F3>', '<cmd>lua vim.lsp.buf.format({async = true})<cr>', opt('Format buffer (LSP)'))
    end
})
