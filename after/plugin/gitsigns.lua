local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
    return
end

gitsigns.setup({
    on_attach = function(buffer)
        local opts = { buffer = buffer, remap = false, silent = true }

        vim.keymap.set('n', '<leader>gg', gitsigns.toggle_signs,                               opts)
        vim.keymap.set('n', '<leader>gb', function() gitsigns.blame_line({ full = true }) end, opts)
        vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk,                               opts)
    end
})
