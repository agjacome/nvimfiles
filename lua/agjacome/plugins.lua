local bootstrap_packer = function()
    local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

    if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end

    return false
end

local is_new_packer_install = bootstrap_packer()

local packer_group = vim.api.nvim_create_augroup('Packer', {})
vim.api.nvim_create_autocmd('BufWritePost', {
    group   = packer_group,
    pattern = 'plugins.lua',
    command = 'source <afile> | PackerSync'
})

return require('packer').startup({
    function(use)
        use { 'wbthomason/packer.nvim' }

        use { 'folke/neodev.nvim' }
        use { 'folke/trouble.nvim' }
        use { 'folke/zen-mode.nvim', requires = 'folke/twilight.nvim' }
        use { 'iamcco/markdown-preview.nvim', run = function() vim.fn['mkdp#util#install']() end }
        use { 'junegunn/vim-easy-align' }
        use { 'lewis6991/gitsigns.nvim' }
        use { 'mbbill/undotree' }
        use { 'mcchrish/zenbones.nvim', requires = 'rktjmp/lush.nvim' }
        use { 'mfussenegger/nvim-dap' }
        use { 'mg979/vim-visual-multi' }
        use { 'norcalli/nvim-colorizer.lua' }
        use { 'numtostr/comment.nvim' }
        use { 'nvim-lua/plenary.nvim' }
        use { 'nvim-lualine/lualine.nvim' }
        use { 'nvim-telescope/telescope-dap.nvim' }
        use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
        use { 'nvim-telescope/telescope-media-files.nvim' }
        use { 'nvim-telescope/telescope.nvim' }
        use { 'nvim-tree/nvim-tree.lua', tag = 'nightly' }
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'nvim-treesitter/nvim-treesitter-context' }
        use { 'scalameta/nvim-metals' }
        use { 'thehamsta/nvim-dap-virtual-text' }
        use { 'tpope/vim-fugitive' }
        use { 'zbirenbaum/copilot.lua' }

        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            requires = {
                { 'hrsh7th/cmp-buffer' },
                { 'hrsh7th/cmp-nvim-lsp' },
                { 'hrsh7th/cmp-nvim-lua' },
                { 'hrsh7th/cmp-path' },
                { 'hrsh7th/nvim-cmp' },
                { 'l3mon4d3/luasnip' },
                { 'neovim/nvim-lspconfig' },
                { 'saadparwaiz1/cmp_luasnip' },
                { 'williamboman/mason-lspconfig.nvim' },
                { 'williamboman/mason.nvim' },
            }
        }

        if is_new_packer_install then
            require('packer').sync()
        end
    end,
    config = {
        display = {
            open_fn = function()
                return require('packer.util').float({
                    border = 'single',
                    height = 20
                })
            end
        }
    }
})
