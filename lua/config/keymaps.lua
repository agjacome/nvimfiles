local util = require('config.util')

local preview_hunk = function()
    local file = vim.fn.expand('%:.')
    if file == '' then
        return
    end

    local result = vim.system({ 'git', 'show', 'HEAD:./' .. file }, { text = true }):wait()
    if result.code ~= 0 then
        vim.notify('File not committed at HEAD', vim.log.levels.WARN)
        return
    end

    local git_lines = vim.split(result.stdout, '\n', { trimempty = false })
    local buf_lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    local diff = vim.diff(result.stdout, table.concat(buf_lines, '\n'), {
        result_type = 'indices',
    })

    local cursor_line = vim.fn.line('.')
    for _, hunk in ipairs(diff) do
        local old_start, old_count, new_start, new_count = hunk[1], hunk[2], hunk[3], hunk[4]
        local hunk_end = new_start + math.max(new_count - 1, 0)

        if new_count > 0 and cursor_line >= new_start and cursor_line <= hunk_end then
            local hunk_lines = {}
            for i = old_start, old_start + old_count - 1 do
                table.insert(hunk_lines, '- ' .. (git_lines[i] or ''))
            end
            for i = new_start, new_start + new_count - 1 do
                table.insert(hunk_lines, '+ ' .. (buf_lines[i] or ''))
            end

            local float_buf = vim.api.nvim_create_buf(false, true)
            vim.api.nvim_buf_set_lines(float_buf, 0, -1, false, hunk_lines)
            vim.bo[float_buf].filetype = 'diff'

            local width = math.min(80, vim.o.columns - 4)
            local height = math.min(#hunk_lines, 20)
            vim.api.nvim_open_win(float_buf, true, {
                relative = 'cursor',
                row = 1,
                col = 0,
                width = width,
                height = height,
                style = 'minimal',
                border = 'single',
            })

            vim.keymap.set('n', 'q', function()
                vim.api.nvim_buf_delete(float_buf, { force = true })
            end, { buffer = float_buf })
            return
        end
    end

    vim.notify('No changes at cursor', vim.log.levels.INFO)
end

-- leaders
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- disabled
vim.keymap.set('n', 'q:', '<nop>')
vim.keymap.set('n', 'q/', '<nop>')
vim.keymap.set('n', 'q?', '<nop>')
vim.keymap.set('n', 'Q', '<nop>')
vim.keymap.set('n', '<left>', '<nop>')
vim.keymap.set('n', '<right>', '<nop>')
vim.keymap.set('n', '<up>', '<nop>')
vim.keymap.set('n', '<down>', '<nop>')

-- navigation
vim.keymap.set('n', '<tab>', ':bnext<cr>', util.map_opts('Buffer - Next'))
vim.keymap.set('n', '<s-tab>', ':bprevious<cr>', util.map_opts('Buffer - Previous'))

-- diagnostics
vim.keymap.set('n', 'gl', vim.diagnostic.open_float, util.map_opts('Diagnostics - Open'))
vim.keymap.set('n', '[d', function()
    vim.diagnostic.jump({ count = -1 })
end, util.map_opts('Diagnostics - Previous'))
vim.keymap.set('n', ']d', function()
    vim.diagnostic.jump({ count = 1 })
end, util.map_opts('Diagnostics - Next'))

-- quickfix
vim.api.nvim_create_autocmd('FileType', {
    group = vim.api.nvim_create_augroup('quickfix', { clear = true }),
    pattern = 'qf',
    callback = function(event)
        vim.keymap.set('n', '<cr>', '<cr>', { buffer = event.buf })
    end,
})

-- custom
vim.keymap.set('n', '<leader>X', '<cmd>source %<cr>', util.map_opts('Source - Current file'))
vim.keymap.set('v', '<leader>X', ':lua<cr>', util.map_opts('Source - Current selection'))
vim.keymap.set('n', '<leader><cr>', function()
    vim.o.hlsearch = not vim.o.hlsearch
end, util.map_opts('Search - Toggle highlight'))

vim.keymap.set('n', '<leader>yp', function()
    local path = vim.fn.expand('%:.')
    vim.fn.setreg('+', path)
    vim.notify('Copied "' .. path .. '" to the clipboard!')
end, util.map_opts('Yank - File path'))

vim.keymap.set('n', '<leader>gd', preview_hunk, util.map_opts('Git - Preview hunk'))

local tmux_session = function()
    if vim.env.TMUX then
        vim.fn.system('tmux split-window -v -l 20 tmux-session')
    else
        print('Not in a tmux session')
    end
end

vim.keymap.set('n', '<c-t>', tmux_session, util.map_opts('Tmux - Switch session'))
