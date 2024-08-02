vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions',
    callback = function(event)
        local options = function(desc)
            return { buffer = event.buffer, silent = true, desc = desc }
        end

        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', options('Go to definition (LSP)'))
        vim.keymap.set('n', 'gD', '<cmd>Telescope lsp_type_definitions<cr>', options('Go to type definition (LSP)'))
        vim.keymap.set('n', 'gi', '<cmd>Telescope lsp_implementations<cr>', options('Go to implementation (LSP)'))
        vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<cr>', options('Go to references (LSP)'))
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_incoming_calls<cr>', options('Go to incoming calls (LSP)'))
        vim.keymap.set('n', 'gO', '<cmd>Telescope lsp_outgoing_calls<cr>', options('Go to outgoing calls (LSP)'))

        vim.keymap.set('n', '<leader>l', '<cmd>Telescope lsp_document_symbols<cr>', options('List symbols (LSP)'))
        vim.keymap.set('n', '<leader>L', '<cmd>Telescope lsp_workspace_symbols<cr>', options('List workspace symbols (LSP)'))

        vim.keymap.set({ 'n', 'x' }, '<F3>', vim.lsp.buf.format, options('Format current buffer (LSP)'))
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
