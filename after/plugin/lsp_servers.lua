local status_ok, lsp_config = pcall(require, 'lspconfig')

if not status_ok then
    return
end

lsp_config.hls.setup({
    cmd = { 'haskell-language-server-wrapper', '--lsp' }
})
