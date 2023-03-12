local status_ok, catppuccin = pcall(require, 'catppuccin')

if not status_ok then
    return
end

catppuccin.setup({
    flavour   = 'macchiato',
    no_italic = true,
    no_bold   = true
})

vim.cmd.Catppuccin('macchiato')

local toggle_colors = function()
    local current_color = vim.g.colors_name
    local current_bg    = vim.o.background

    if current_color == 'catppuccin' and current_bg == 'dark' then
        vim.cmd.Catppuccin('latte')
    elseif current_color == 'catppuccin' and current_bg == 'light' then
        vim.cmd.colorscheme('off')
        vim.o.background  = 'dark'
    elseif current_color == 'off' and current_bg == 'dark' then
        vim.cmd.colorscheme('off')
        vim.o.background  = 'light'
    else -- if current_color == 'off' and current_bg = 'dark' then
        vim.cmd.Catppuccin('macchiato')
    end

    print('color: ' .. vim.g.colors_name .. '-' .. vim.o.background)
end

vim.keymap.set('n', '<f5>', toggle_colors, { remap = false, desc = 'Toggle colorscheme' })
