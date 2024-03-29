local status_ok, lualine = pcall(require, 'lualine')

if not status_ok then
    return
end

lualine.setup({
    options = {
        component_separators = '|',
        icons_enabled        = false,
        section_separators   = '',
        theme                = 'zenbones',
    },
    tabline = {
        lualine_a = {
            {
                'buffers',
                mode               = 0,
                show_filename_only = false,
                filetype_names = {
                    NvimTree        = 'NVimTree',
                    TelescopePrompt = 'Telescope',
                    fugitive        = 'Fugitive',
                    packer          = 'Packer',
                },
                symbols = {
                    modified       = '*',
                    alternate_file = '',
                    directory      = '',
                }
            }
        },
    },
})
