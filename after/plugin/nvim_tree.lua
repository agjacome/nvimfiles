vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

require('nvim-tree').setup({
    actions = {
        open_file = {
            quit_on_open = true,
            window_picker = {
                enable = false
            }
        }
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file         = false,
                folder       = false,
                folder_arrow = true,
                git          = false,
                modified     = false
            }
        }
    }
})

vim.keymap.set('n', '<leader>f', ':NvimTreeToggle<CR>', { silent = true, noremap =  true }) 
