vim.g.zenbones = {
  lightness = 'dim',
  italic_comments = false,
}

local current_style_idx = 1;
local styles = {
    { color = 'zenbones',    background = 'dark', },
    { color = 'zenbones',    background = 'light' },
    { color = 'forestbones', background = 'dark'  },
    { color = 'forestbones', background = 'light' },
}

local set_colors = function(index)
    local style = styles[index]

    vim.o.background = style.background
    vim.cmd.colorscheme(style.color)
end

local toggle_colors = function()
    current_style_idx = math.fmod(current_style_idx, #styles) + 1
    set_colors(current_style_idx)
end

set_colors(current_style_idx)

vim.keymap.set('n', '<f5>', toggle_colors, { remap = false, desc = 'Toggle colors' })
