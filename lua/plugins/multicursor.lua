return {
    'jake-stewart/multicursor.nvim',
    branch = '1.0',
    event = 'VeryLazy',
    config = function()
        local util = require('config.util')
        local mc = require('multicursor-nvim')
        mc.setup()

        local set = vim.keymap.set

        set({ 'n', 'x' }, '<c-n>', function()
            mc.matchAddCursor(1)
        end, util.map_opts('Multicursor - Add on match'))

        set({ 'n', 'x' }, '<c-up>', function()
            mc.lineAddCursor(-1)
        end, util.map_opts('Multicursor - Add above'))
        set({ 'n', 'x' }, '<c-down>', function()
            mc.lineAddCursor(1)
        end, util.map_opts('Multicursor - Add below'))

        set({ 'n', 'x' }, '<leader>A', mc.matchAllAddCursors, util.map_opts('Multicursor - Add all matches'))

        mc.addKeymapLayer(function(layerSet)
            layerSet({ 'n', 'x' }, 'n', function()
                mc.matchAddCursor(1)
            end)
            layerSet({ 'n', 'x' }, 'N', function()
                mc.matchAddCursor(-1)
            end)
            layerSet({ 'n', 'x' }, 'q', function()
                mc.matchSkipCursor(1)
            end)
            layerSet({ 'n', 'x' }, 'Q', mc.deleteCursor)

            layerSet({ 'n', 'x' }, '<left>', mc.prevCursor)
            layerSet({ 'n', 'x' }, '<right>', mc.nextCursor)

            layerSet('n', '<esc>', function()
                if not mc.cursorsEnabled() then
                    mc.enableCursors()
                else
                    mc.clearCursors()
                end
            end)
        end)

        local hl = vim.api.nvim_set_hl
        hl(0, 'MultiCursorCursor', { reverse = true })
        hl(0, 'MultiCursorVisual', { link = 'Visual' })
        hl(0, 'MultiCursorSign', { link = 'SignColumn' })
        hl(0, 'MultiCursorMatchPreview', { link = 'Search' })
        hl(0, 'MultiCursorDisabledCursor', { reverse = true })
        hl(0, 'MultiCursorDisabledVisual', { link = 'Visual' })
        hl(0, 'MultiCursorDisabledSign', { link = 'SignColumn' })
    end,
}
