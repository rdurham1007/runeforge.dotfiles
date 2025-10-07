return {
  'mfussenegger/nvim-dap',
  dependencies = {
    {
      'rcarriga/nvim-dap-ui',
      config = function()
        require('dapui').setup()
      end,
    },
  },
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'

    -- Netcoredbg adapter for C#
    dap.adapters.netcoredbg = {
      type = 'executable',
      command = vim.fn.stdpath 'data' .. '/mason/packages/netcoredbg/netcoredbg',
      args = { '--interpreter=vscode' },
    }

    -- Configuration for C# debugging
    dap.configurations.cs = {
      {
        type = 'netcoredbg',
        name = 'Launch - Netcoredbg',
        request = 'launch',
        program = function()
          return vim.fn.input('Path to DLL > ', vim.fn.getcwd() .. '/bin/Debug/', 'file')
        end,
      },
    }

    -- Keymaps
    vim.keymap.set('n', '<leader>db', function()
      dap.toggle_breakpoint()
    end, { desc = 'Toggle breakpoint' })

    vim.keymap.set('n', '<leader>dc', function()
      dap.continue()
    end, { desc = 'Continue' })

    vim.keymap.set('n', '<leader>di', function()
      dap.step_into()
    end, { desc = 'Step into' })

    vim.keymap.set('n', '<leader>do', function()
      dap.step_over()
    end, { desc = 'Step over' })

    vim.keymap.set('n', '<leader>dO', function()
      dap.step_out()
    end, { desc = 'Step out' })

    vim.keymap.set('n', '<leader>dr', function()
      dap.repl.toggle()
    end, { desc = 'Toggle REPL' })

    vim.keymap.set('n', '<leader>dl', function()
      dap.run_last()
    end, { desc = 'Run last' })
    vim.keymap.set('n', '<Leader>du', dapui.toggle, { desc = 'DAP UI Toggle' })
    vim.keymap.set('n', '<Leader>de', dapui.eval, { desc = 'DAP UI Eval' })

    -- Auto open/close dapui
    dap.listeners.after.event_initialized['dapui_config'] = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated['dapui_config'] = function()
      dapui.close()
    end
    dap.listeners.before.event_exited['dapui_config'] = function()
      dapui.close()
    end
  end,
}
