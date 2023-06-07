local lsp_status_ok, lsp_zero = pcall(require, 'lsp-zero')

if not lsp_status_ok then
    return
end

lsp_zero.preset({
    name                = 'recommended',
    set_lsp_keymaps     = true,
    manage_nvim_cmp     = true,
    suggest_lsp_servers = false,
})

local neodev_status_ok, neodev = pcall(require, 'neodev')
if neodev_status_ok then
    neodev.setup()
end

lsp_zero.setup()

local lsp_config = require('lspconfig')

lsp_config.denols.setup {
  on_attach = on_attach,
  root_dir = lsp_config.util.root_pattern("deno.json", "deno.jsonc"),
}

lsp_config.tsserver.setup {
  on_attach = on_attach,
  root_dir = lsp_config.util.root_pattern("package.json"),
  single_file_support = false
}
