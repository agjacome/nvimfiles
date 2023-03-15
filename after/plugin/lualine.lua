local status_ok, lualine = pcall(require, 'lualine')

if not status_ok then
    return
end

lualine.setup({
    options = {
        component_separators = '|',
        icons_enabled        = false,
        section_separators   = '',
        theme                = 'onedark',
    },
    tabline = {
      lualine_a = {
          {
              'buffers',
              mode    = 0,
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
