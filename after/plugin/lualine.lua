require('lualine').setup({
    options = {
        icons_enabled = false,
        theme         = 'powerline'
    },
    tabline = {
      lualine_a = {
          {
              'buffers',
              mode    = 2,
              symbols = {
                  modified       = '*',
                  alternate_file = '',
                  directory      = '',
              }
          }
      },
    },
})
