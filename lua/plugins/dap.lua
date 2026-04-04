return {
    {
        'mfussenegger/nvim-dap',
        dependencies = {
            'rcarriga/nvim-dap-ui',
            'nvim-neotest/nvim-nio',
            'theHamsta/nvim-dap-virtual-text',
            'nvim-telescope/telescope-dap.nvim',
        },
        keys = { '<leader>db', '<leader>du', '<F7>' },
        config = function()
            local Opts = require('config.util')
            local dap = require('dap')
            local dapui = require('dapui')

            dapui.setup()

            require('nvim-dap-virtual-text').setup({
                commented = true,
                virt_text_pos = 'inline',
            })

            -- auto open/close dap-ui with debug session
            dap.listeners.before.attach.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                dapui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                dapui.close()
            end

            -- stepping
            vim.keymap.set('n', '<F5>', dap.step_into, Opts('DAP - Step into'))
            vim.keymap.set('n', '<F6>', dap.step_over, Opts('DAP - Step over'))
            vim.keymap.set('n', '<F7>', dap.continue, Opts('DAP - Continue'))
            vim.keymap.set('n', '<F8>', dap.step_out, Opts('DAP - Step out'))

            -- breakpoints
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, Opts('DAP - Toggle breakpoint'))
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end, Opts('DAP - Conditional breakpoint'))
            vim.keymap.set('n', '<leader>dl', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end, Opts('DAP - Log point'))

            -- session control
            vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, Opts('DAP - Run to cursor'))
            vim.keymap.set('n', '<leader>dq', dap.terminate, Opts('DAP - Terminate'))
            vim.keymap.set('n', '<leader>dR', dap.restart, Opts('DAP - Restart'))

            -- ui
            vim.keymap.set('n', '<leader>du', dapui.toggle, Opts('DAP - Toggle UI'))
            vim.keymap.set('n', '<leader>dr', dap.repl.toggle, Opts('DAP - Toggle REPL'))
            vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, Opts('DAP - Eval expression'))

            -- telescope
            require('telescope').load_extension('dap')
            vim.keymap.set(
                'n',
                '<leader>ds',
                '<cmd>Telescope dap configurations<cr>',
                Opts('DAP - Select configuration')
            )
        end,
    },
}
