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
    style = 'warm',
    -- self-managed to include also 'off' colorscheme (see below)
    -- toggle_style_key  = '<f5>',
    -- toggle_style_list = { 'light', 'warm' },
})

local current_style_idx = 1;
local styles = {
    { color = 'off',     background = 'dark',  style = 'warm'  },
    { color = 'onedark', background = 'dark',  style = 'warm'  },
    { color = 'off',     background = 'light', style = 'light' },
    { color = 'onedark', background = 'light', style = 'light' },
}

local set_colors = function(index)
    local style = styles[index]

    vim.o.background = style.background
    vim.g.onedark_config.style = style.style
    vim.cmd.colorscheme(style.color)
end

local toggle_colors = function()
    current_style_idx = math.fmod(current_style_idx, #styles) + 1
    set_colors(current_style_idx)
end

onedark.load()
set_colors(current_style_idx)

vim.keymap.set('n', '<f5>', toggle_colors, { remap = false, desc = 'Toggle colors' })
