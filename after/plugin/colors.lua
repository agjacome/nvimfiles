local status_ok, onedark = pcall(require, 'onedark')

if not status_ok then
    return
end

onedark.setup({
    code_style = {
        comments  = 'none',
        keywords  = 'none',
        functions = 'none',
        strings   = 'none',
        variables = 'none'
    },
    style = 'warmer',
    -- self-managed to include also 'off' colorscheme (see below)
    -- toggle_style_key  = '<f5>',
    -- toggle_style_list = { 'light', 'warmer' },
})

onedark.load()

local current_style_idx = 1;
local styles = {
    { color = 'onedark', background = 'dark',  style = 'warmer' },
    { color = 'off',     background = 'dark',  style = 'warmer' },
    { color = 'onedark', background = 'light', style = 'light'  },
    { color = 'off',     background = 'light', style = 'light'  },
}

local toggle_colors = function()
    current_style_idx = math.fmod(current_style_idx, #styles) + 1

    local style = styles[current_style_idx]

    vim.cmd.colorscheme(style.color)
    vim.g.onedark_config.style = style.style
    vim.o.background = style.background
end

vim.keymap.set('n', '<f5>', toggle_colors, { remap = false, desc = 'Toggle colors' })
