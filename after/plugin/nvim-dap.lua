local status_ok, dap = pcall(require, 'dap')

if not status_ok then
    return
end

local opts = function(desc)
    return { desc = desc, remap = false, silent = true }
end

vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, opts('Toggle breakpoint (DAP)'))
vim.keymap.set('n', '<leader>dc', dap.continue,          opts('Continue (DAP)'))
vim.keymap.set('n', '<leader>di', dap.step_into,         opts('Step into (DAP)'))
vim.keymap.set('n', '<leader>do', dap.step_over,         opts('Step over (DAP)'))
vim.keymap.set('n', '<leader>dr', dap.repl.open,         opts('Open REPL (DAP)'))

local text_status_ok, dap_text = pcall(require, 'nvim-dap-virtual-text')

if text_status_ok then
    dap_text.setup({})
end

local telescope_status_ok, telescope = pcall(require, 'telescope')

if telescope_status_ok then
    vim.keymap.set('n', '<leader>dv', telescope.extensions.dap.variables,        opts('List variables (DAP Telescope)'))
    vim.keymap.set('n', '<leader>dl', telescope.extensions.dap.list_breakpoints, opts('List breakpoints (DAP Telescope)'))
end
