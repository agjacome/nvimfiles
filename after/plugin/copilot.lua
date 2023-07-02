local status_ok, copilot = pcall(require, 'copilot')

if not status_ok then
    return
end

copilot.setup({
    panel = {
        auto_refresh = false
    },
    suggestion = {
        auto_trigger = true
    }
})

local trigger_auto_suggest = function()
    require('copilot.suggestion').toggle_auto_trigger()
end

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<leader>cp', trigger_auto_suggest, opts('Toggle Copilot auto-suggest'))
