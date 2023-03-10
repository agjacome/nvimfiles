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
