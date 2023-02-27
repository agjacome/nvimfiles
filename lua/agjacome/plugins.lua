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

return require('packer').startup(function(use)
  -- https://github.com/wbthomason/packer.nvim
  use 'wbthomason/packer.nvim'

  use 'pbrisbin/vim-colors-off'
  use 'w0ng/vim-hybrid'
  use { 'nvim-telescope/telescope.nvim', tag = '0.1.x', requires = { {'nvim-lua/plenary.nvim'} } }

  if is_new_packer_install then
    require('packer').sync()
  end
end)
