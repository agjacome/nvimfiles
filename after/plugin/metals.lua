local status_ok, metals = pcall(require, 'metals')

if not status_ok then
    return
end

local config = metals.bare_config()

config.settings = {
    excludedPackages      = { "akka.actor.typed.javadsl", "com.github.swagger.akka.javadsl" },
    showImplicitArguments = true,
    showInferredType      = true,
}

config.init_options.statusBarProvider = "on"
config.capabilities = require("cmp_nvim_lsp").default_capabilities()

local group   = vim.api.nvim_create_augroup('metals', { clear = true })
local autocmd = vim.api.nvim_create_autocmd

local callback = function()
    metals.initialize_or_attach(config)

    local opts = { remap = false, silent = true }

    -- set same LSP keymaps as lsp-zero
    vim.keymap.set('n', 'K',    '<cmd>lua vim.lsp.buf.hover()<cr>',                  opts)
    vim.keymap.set('n', 'gd',   '<cmd>lua vim.lsp.buf.definition()<cr>',             opts)
    vim.keymap.set('n', 'gD',   '<cmd>lua vim.lsp.buf.declaration()<cr>',            opts)
    vim.keymap.set('n', 'gi',   '<cmd>lua vim.lsp.buf.implementation()<cr>',         opts)
    vim.keymap.set('n', 'go',   '<cmd>lua vim.lsp.buf.type_definition()<cr>',        opts)
    vim.keymap.set('n', 'gr',   '<cmd>lua vim.lsp.buf.references()<cr>',             opts)
    vim.keymap.set('n', 'gs',   '<cmd>lua vim.lsp.buf.signature_help()<cr>',         opts)
    vim.keymap.set('n', '<F2>', '<cmd>lua vim.lsp.buf.rename()<cr>',                 opts)
    vim.keymap.set('n', '<F4>', '<cmd>lua vim.lsp.buf.code_action()<cr>',            opts)
    vim.keymap.set('n', '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)
    vim.keymap.set('x', '<F3>', '<cmd>lua vim.lsp.buf.format({ async = true })<cr>', opts)

    vim.keymap.set('n', '<leader>ws', metals.hover_worksheet, opts)
end

autocmd('FileType', {
    group = group,
    pattern = { 'scala', 'sbt' },
    callback = callback
})

