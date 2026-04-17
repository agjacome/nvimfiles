local util = require('config.util')

-- Enable native completion and Telescope keymaps on LSP attach
vim.api.nvim_create_autocmd('LspAttach', {
    desc = 'LSP Actions',
    callback = function(event)
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        local buf = event.buf

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end

        vim.keymap.set('n', 'gd', '<cmd>Telescope lsp_definitions<cr>', util.map_opts('LSP - Definition', buf))
        vim.keymap.set(
            'n',
            'gD',
            '<cmd>Telescope lsp_type_definitions<cr>',
            util.map_opts('LSP - Type definition', buf)
        )
        vim.keymap.set('n', 'gri', '<cmd>Telescope lsp_implementations<cr>', util.map_opts('LSP - Implementation', buf))
        vim.keymap.set('n', 'gI', '<cmd>Telescope lsp_incoming_calls<cr>', util.map_opts('LSP - Incoming calls', buf))
        vim.keymap.set('n', 'gO', '<cmd>Telescope lsp_outgoing_calls<cr>', util.map_opts('LSP - Outgoing calls', buf))
        vim.keymap.set('n', 'grr', '<cmd>Telescope lsp_references<cr>', util.map_opts('LSP - References', buf))
        vim.keymap.set('n', '<leader>l', '<cmd>Telescope lsp_document_symbols<cr>', util.map_opts('LSP - Symbols', buf))
        vim.keymap.set(
            'n',
            '<leader>L',
            '<cmd>Telescope lsp_workspace_symbols<cr>',
            util.map_opts('LSP - Workspace symbols', buf)
        )
        vim.keymap.set(
            { 'n', 'x' },
            'grf',
            '<cmd>lua vim.lsp.buf.format({async = true})<cr>',
            util.map_opts('LSP - Format', buf)
        )
        vim.keymap.set('n', '<leader>ih', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, util.map_opts('LSP - Toggle inlay hints', buf))
    end,
})

-- Diagnostic display
vim.diagnostic.config({
    update_in_insert = false,
    float = {
        focusable = false,
        source = 'if_many',
        header = '',
        prefix = '',
    },
})

-- Show LSP progress in cmdline
vim.api.nvim_create_autocmd('LspProgress', {
    desc = 'LSP progress',
    callback = function()
        vim.api.nvim_echo({ { vim.lsp.status(), 'NonText' } }, false, {})
    end,
})

-- Enable servers
vim.lsp.enable({ 'lua_ls', 'bashls', 'dockerls', 'jsonls', 'marksman', 'nixd', 'taplo', 'yamlls' })
