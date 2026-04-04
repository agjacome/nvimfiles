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
            local util = require('config.util')
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
            vim.keymap.set('n', '<F5>', dap.step_into, util.map_opts('DAP - Step into'))
            vim.keymap.set('n', '<F6>', dap.step_over, util.map_opts('DAP - Step over'))
            vim.keymap.set('n', '<F7>', dap.continue, util.map_opts('DAP - Continue'))
            vim.keymap.set('n', '<F8>', dap.step_out, util.map_opts('DAP - Step out'))

            -- breakpoints
            vim.keymap.set('n', '<leader>db', dap.toggle_breakpoint, util.map_opts('DAP - Toggle breakpoint'))
            vim.keymap.set('n', '<leader>dB', function()
                dap.set_breakpoint(vim.fn.input('Breakpoint condition: '))
            end, util.map_opts('DAP - Conditional breakpoint'))
            vim.keymap.set('n', '<leader>dl', function()
                dap.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))
            end, util.map_opts('DAP - Log point'))

            -- session control
            vim.keymap.set('n', '<leader>dc', dap.run_to_cursor, util.map_opts('DAP - Run to cursor'))
            vim.keymap.set('n', '<leader>dq', dap.terminate, util.map_opts('DAP - Terminate'))
            vim.keymap.set('n', '<leader>dR', dap.restart, util.map_opts('DAP - Restart'))

            -- ui
            vim.keymap.set('n', '<leader>du', dapui.toggle, util.map_opts('DAP - Toggle UI'))
            vim.keymap.set('n', '<leader>dr', dap.repl.toggle, util.map_opts('DAP - Toggle REPL'))
            vim.keymap.set({ 'n', 'v' }, '<leader>de', dapui.eval, util.map_opts('DAP - Eval expression'))

            -- telescope
            require('telescope').load_extension('dap')
            vim.keymap.set(
                'n',
                '<leader>ds',
                '<cmd>Telescope dap configurations<cr>',
                util.map_opts('DAP - Select configuration')
            )
        end,
    },
}
