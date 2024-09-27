vim.opt.autoindent     = true
vim.opt.autoread       = true
vim.opt.autowrite      = true
vim.opt.backspace      = 'indent,eol,start'
vim.opt.backup         = false
vim.opt.breakindent    = true
vim.opt.clipboard      = 'unnamedplus'
vim.opt.complete       = '.,b,u,]'
vim.opt.completeopt    = 'longest,menu'
vim.opt.diffopt        = 'filler'
vim.opt.directory      = '/tmp'
vim.opt.expandtab      = true
vim.opt.exrc           = true
vim.opt.fillchars      = vim.o.fillchars .. 'vert:│'
vim.opt.fixendofline   = true
vim.opt.foldenable     = false
vim.opt.foldmethod     = 'manual'
vim.opt.formatoptions  = vim.o.formatoptions .. 'j'
vim.opt.guicursor      = ''
vim.opt.hidden         = true
vim.opt.history        = 10000
vim.opt.hlsearch       = true
vim.opt.ignorecase     = true
vim.opt.incsearch      = true
vim.opt.joinspaces     = false
vim.opt.laststatus     = 3
vim.opt.list           = true
vim.opt.listchars      = { extends = '❯', nbsp = '⋅', precedes = '❮', space = '⋅', tab = '▸ ', trail = '⋅' }
vim.opt.number         = true
vim.opt.numberwidth    = 2
vim.opt.pumheight      = 10
vim.opt.relativenumber = true
vim.opt.ruler          = true
vim.opt.scrolloff      = 10
vim.opt.shiftwidth     = 4
vim.opt.shortmess      = vim.o.shortmess .. 'c' .. 'I'
vim.opt.showbreak      = '↳ '
vim.opt.showtabline    = 2
vim.opt.signcolumn     = 'yes'
vim.opt.smartcase      = true
vim.opt.smartindent    = true
vim.opt.softtabstop    = 4
vim.opt.swapfile       = false
vim.opt.tabstop        = 4
vim.opt.termguicolors  = true
vim.opt.textwidth      = 79
vim.opt.timeoutlen     = 500
vim.opt.title          = true
vim.opt.titleold       = ''
vim.opt.titlestring    = 'nvim: %F'
vim.opt.undodir        = os.getenv('HOME') .. '/.cache/nvim/undo'
vim.opt.undofile       = true
vim.opt.undolevels     = 100
vim.opt.undoreload     = 10000
vim.opt.updatetime     = 300
vim.opt.virtualedit    = 'block'
vim.opt.wildmode       = 'longest,list'
vim.opt.wrap           = false
vim.opt.writebackup    = false
