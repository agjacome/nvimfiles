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
    git ={
        enable = true,
        ignore = false,
        timeout = 500
    },
    renderer = {
        group_empty = true,
        icons = {
            show = {
                file         = false,
                folder       = false,
                folder_arrow = true,
                git          = false,
                modified     = false,
            },
            glyphs = {
                symlink = ''
            },
            symlink_arrow = ' → '
        }
    },
    update_focused_file = {
        enable = true
    },
})

local open_nvim_tree = function(data)
    local is_directory = vim.fn.isdirectory(data.file) == 1

    if not is_directory then
        return
    end

    vim.cmd.cd(data.file)
    vim.cmd.NvimTreeOpen()
end

vim.keymap.set('n', '<leader>f', vim.cmd.NvimTreeFindFileToggle, { desc = 'Toggle NvimTree', remap = false, silent = true })

vim.api.nvim_create_autocmd({ 'VimEnter' }, { callback = open_nvim_tree })
