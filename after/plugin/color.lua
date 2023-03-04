vim.cmd.colorscheme('hybrid')
vim.o.background  = 'dark'

function toggle_colors()
    local current_color = vim.g.colors_name
    local current_bg    = vim.o.background

    if current_color == 'hybrid' and current_bg == 'dark' then
        vim.cmd.colorscheme('hybrid')
        vim.o.background  = 'light'
    elseif current_color == 'hybrid' and current_bg == 'light' then
        vim.cmd.colorscheme('off')
        vim.o.background  = 'dark'
    elseif current_color == 'off' and current_bg == 'dark' then
        vim.cmd.colorscheme('off')
        vim.o.background  = 'light'
    else -- if current_color == 'off' and current_bg = 'dark' then
        vim.cmd.colorscheme('hybrid')
        vim.o.background  = 'dark'
    end

    print('color: ' .. vim.g.colors_name .. '-' .. vim.o.background)
end

vim.keymap.set('n', '<f5>', toggle_colors, { noremap = true })
