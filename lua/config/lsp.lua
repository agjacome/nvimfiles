local util = require('config.util')

local M = {}

-- LSP progress cache keyed by client id
M.progress_cache = {}

function M.progress()
    local parts = {}
    for _, v in pairs(M.progress_cache) do
        table.insert(parts, v)
    end
    return table.concat(parts, ' | ')
end

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

-- Show LSP progress in statusline
vim.api.nvim_create_autocmd('LspProgress', {
    desc = 'LSP progress',
    callback = function(args)
        local value = vim.tbl_get(args, 'data', 'params', 'value')
        if not value or not value.kind then
            return
        end
        local client_id = args.data.client_id
        if value.kind == 'end' then
            M.progress_cache[client_id] = nil
        else
            local client = vim.lsp.get_client_by_id(client_id)
            local name = client and client.name or 'lsp'
            local bits = {}
            if value.title then
                table.insert(bits, value.title)
            end
            if value.message then
                table.insert(bits, value.message)
            end
            if value.percentage then
                table.insert(bits, value.percentage .. '%%')
            end
            M.progress_cache[client_id] = ('[%s] %s'):format(name, table.concat(bits, ' '))
        end
        vim.cmd.redrawstatus()
    end,
})

-- Drop progress entries for clients that detach without emitting 'end'
vim.api.nvim_create_autocmd('LspDetach', {
    desc = 'LSP progress cleanup',
    callback = function(args)
        M.progress_cache[args.data.client_id] = nil
        vim.cmd.redrawstatus()
    end,
})

-- Enable servers
vim.lsp.enable({ 'lua_ls', 'bashls', 'dockerls', 'jsonls', 'marksman', 'nixd', 'taplo', 'yamlls' })

return M
