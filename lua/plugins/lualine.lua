return {
    "nvim-lualine/lualine.nvim",
    lazy = false,
    opts = {
        options = {
            component_separators = "|",
            icons_enabled        = false,
            section_separators   = "",
            theme                = "zenbones",
        },
        tabline = {
            lualine_a = {
                {
                    "buffers",
                    mode               = 0,
                    show_filename_only = false,
                    filetype_names = {
                        NvimTree        = "NVimTree",
                        TelescopePrompt = "Telescope",
                        fugitive        = "Fugitive",
                    },
                    symbols = {
                        modified       = "*",
                        alternate_file = "",
                        directory      = "",
                    }
                }
            },
        }
    }
}
