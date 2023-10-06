local status_ok, gitsigns = pcall(require, 'gitsigns')

if not status_ok then
    return
end

gitsigns.setup({
    on_attach = function(buffer)
        local opts = function(desc)
            return { buffer = buffer, desc = desc, remap = false, silent = true }
        end

        vim.keymap.set('n', '<leader>gg', gitsigns.toggle_signs, opts('Toggle GitSigns'))
        vim.keymap.set('n', '<leader>gp', gitsigns.preview_hunk, opts('Display git hunk preview (GitSigns)'))
    end
})
