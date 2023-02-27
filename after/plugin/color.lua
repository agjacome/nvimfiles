vim.cmd.colorscheme('hybrid')
vim.o.background = 'dark'

function toggle_colors()
    local color = vim.g.colors_name
    local mode  = vim.o.background

    if color == 'hybrid' and mode == 'light' then
        vim.o.background = 'dark'
        vim.cmd.colorscheme('off')
    elseif color == 'hybrid' and mode == 'dark' then
        vim.o.background = 'light'
        vim.cmd.colorscheme('hybrid')
    else
        vim.o.background = 'dark'
        vim.cmd.colorscheme('hybrid')
    end
end

vim.api.nvim_create_user_command('ToggleColors', toggle_colors, { })
vim.keymap.set('n', '<F5>', toggle_colors)
