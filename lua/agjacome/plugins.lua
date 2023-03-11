local bootstrap_packer = function()
  local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'

  if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
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

        use { 'folke/neodev.nvim'                                  }
        use { 'folke/trouble.nvim'                                 }
        use { 'folke/zen-mode.nvim'                                }
        use { 'junegunn/vim-easy-align'                            }
        use { 'justinmk/vim-gtfo'                                  }
        use { 'lewis6991/gitsigns.nvim'                            }
        use { 'mbbill/undotree'                                    }
        use { 'mg979/vim-visual-multi'                             }
        use { 'numtostr/comment.nvim'                              }
        use { 'nvim-lua/plenary.nvim'                              }
        use { 'nvim-lualine/lualine.nvim'                          }
        use { 'nvim-telescope/telescope.nvim',   tag = '0.1.x'     }
        use { 'nvim-tree/nvim-tree.lua',         tag = 'nightly'   }
        use { 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' }
        use { 'nvim-treesitter/nvim-treesitter-context'            }
        use { 'pbrisbin/vim-colors-off'                            }
        use { 'tpope/vim-fugitive'                                 }
        use { 'w0ng/vim-hybrid'                                    }

        use {
            'iamcco/markdown-preview.nvim',
            run = function() vim.fn["mkdp#util#install"]() end
        }

        use {
            'VonHeikemen/lsp-zero.nvim',
            branch = 'v1.x',
            requires = {
                -- LSP Support
                {'neovim/nvim-lspconfig'},
                {'williamboman/mason.nvim'},
                {'williamboman/mason-lspconfig.nvim'},

                -- Autocompletion
                {'hrsh7th/nvim-cmp'},
                {'hrsh7th/cmp-nvim-lsp'},
                {'hrsh7th/cmp-buffer'},
                {'hrsh7th/cmp-path'},
                {'saadparwaiz1/cmp_luasnip'},
                {'hrsh7th/cmp-nvim-lua'},

                -- Snippets
                {'L3MON4D3/LuaSnip'},
                {'rafamadriz/friendly-snippets'},
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

