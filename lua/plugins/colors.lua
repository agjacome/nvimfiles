return {
    "mcchrish/zenbones.nvim",
    dependencies = {
        "rktjmp/lush.nvim",
    },
    lazy = false,
    config = function()
        vim.g.zenbones = {
          lightness = 'dim',
          italic_comments = false,
        }

        vim.o.background = 'dark'
        vim.cmd.colorscheme('zenbones')

        local toggle_background = function()
            vim.o.background = vim.o.background == 'dark' and 'light' or 'dark'
        end

        vim.keymap.set('n', '<f12>', toggle_background, { remap = false, desc = 'Toggle background' })
    end,
}