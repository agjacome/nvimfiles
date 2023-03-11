local status_ok, nvim_tree = pcall(require, 'nvim-tree')

if not status_ok then
    return
end

vim.g.loaded_netrw       = 1
vim.g.loaded_netrwPlugin = 1

nvim_tree.setup({
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
    },
    update_focused_file = {
        enable = true
    }
})

vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeFindFileToggle, { desc = 'Toggle NvimTree', remap = false, silent = true })
