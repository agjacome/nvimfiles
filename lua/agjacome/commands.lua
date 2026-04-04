local group   = vim.api.nvim_create_augroup('agjacome', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

-- Restore cursor position when reopening a file
autocmd('BufReadPost', {
    group   = group,
    pattern = '*',
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        if mark[1] > 0 and mark[1] <= vim.api.nvim_buf_line_count(0) then
            vim.api.nvim_win_set_cursor(0, mark)
        end
    end
})

-- Remove trailing whitespaces on save
autocmd('BufWritePre', {
    group   = group,
    pattern = '*',
    callback = function()
        local ft = vim.bo.filetype
        if ft ~= 'markdown' and ft ~= 'text' then
            local view = vim.fn.winsaveview()
            vim.cmd([[silent! %s/\s\+$//e]])
            vim.fn.winrestview(view)
        end
    end
})

-- Clear command from ruler after 5ms
autocmd('CmdlineLeave', {
    group = group,
    pattern = '*',
    callback = function()
        vim.defer_fn(function() vim.cmd('echon " "') end, 500)
    end
})

-- Highlight yanked text
autocmd('TextYankPost', {
    group    = group,
    pattern  = '*',
    callback = function()
        vim.hl.on_yank({
            higroup = 'IncSearch',
            timeout = 150
        })
    end
})

-- LSP: enable native completion and Telescope keymaps
autocmd('LspAttach', {
    group = group,
    desc  = "LSP Actions",
    callback = function(event)
        local Opts = require('agjacome.opts')
        local client = assert(vim.lsp.get_client_by_id(event.data.client_id))
        local buf = event.buf

        if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, buf, { autotrigger = true })
        end

        vim.keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<cr>", Opts("LSP - Definition", buf))
        vim.keymap.set("n", "gD", "<cmd>Telescope lsp_type_definitions<cr>", Opts("LSP - Type definition", buf))
        vim.keymap.set("n", "gri", "<cmd>Telescope lsp_implementations<cr>", Opts("LSP - Implementation", buf))
        vim.keymap.set("n", "gI", "<cmd>Telescope lsp_incoming_calls<cr>", Opts("LSP - Incoming calls", buf))
        vim.keymap.set("n", "gO", "<cmd>Telescope lsp_outgoing_calls<cr>", Opts("LSP - Outgoing calls", buf))
        vim.keymap.set("n", "grr", "<cmd>Telescope lsp_references<cr>", Opts("LSP - References", buf))
        vim.keymap.set("n", "<leader>l", "<cmd>Telescope lsp_document_symbols<cr>", Opts("LSP - Symbols", buf))
        vim.keymap.set("n", "<leader>L", "<cmd>Telescope lsp_workspace_symbols<cr>", Opts("LSP - Workspace symbols", buf))
        vim.keymap.set({ "n", "x" }, "grf", "<cmd>lua vim.lsp.buf.format({async = true})<cr>", Opts("LSP - Format", buf))
    end
})

-- LSP: diagnostic display
vim.diagnostic.config({
    update_in_insert = false,
    float = {
        focusable = false,
        source = "if_many",
        header = "",
        prefix = "",
    },
})

-- LSP: enable servers
vim.lsp.enable('lua_ls')

-- Copy current file relative path to clipboard
vim.api.nvim_create_user_command("Cppath", function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg("+", path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, {})
