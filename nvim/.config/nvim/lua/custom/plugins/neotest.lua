return {
  'nvim-neotest/neotest',
  dependencies = {
    'nvim-neotest/neotest-python',
    'nvim-neotest/neotest-plenary',
    'nvim-neotest/nvim-nio',
    'antoinemadec/FixCursorHold.nvim',
    'nvim-treesitter/nvim-treesitter',
    'nvim-neotest/neotest-vim-test',
    {
      'neotest-dotnet',
      url = 'git@github.com:Issafalcon/neotest-dotnet.git',
    },
  },
  config = function()
    require('neotest').setup {
      adapters = {
        require 'neotest-python' {
          dap = { justMyCode = false }, -- use debugpy for Python
          args = { '--log-level', 'DEBUG' }, -- optional pytest args
        },
        require 'neotest-dotnet' { -- C# adapter
          dap = {
            justMyCode = false,
            adapter_name = 'netcoredbg', -- or your preferred debugger
          },
          dotnet_additional_args = { '--verbosity', 'detailed' },
          discovery_root = 'solution', -- or "project"
        },
      },
      output_panel = {
        enabled = true,
        open = 'botright vsplit | vertical resize 80',
      },
    }

    local neotest = require 'neotest'

    vim.keymap.set('n', '<leader>tn', function()
      neotest.run.run()
    end, { desc = 'Run nearest test' })
    vim.keymap.set('n', '<leader>tf', function()
      neotest.run.run(vim.fn.expand '%')
    end, { desc = 'Run all tests in file' })
    vim.keymap.set('n', '<leader>td', function()
      neotest.run.run { strategy = 'dap' }
    end, { desc = 'Debug nearest test' })
    vim.keymap.set('n', '<leader>ts', neotest.summary.toggle, { desc = 'Toggle test summary' })
    vim.keymap.set('n', '<leader>to', neotest.output.open, { desc = 'Open test output' })
    vim.keymap.set('n', '<leader>tO', function()
      neotest.output_panel.toggle()
    end, { desc = 'Toggle output panel' })
    vim.keymap.set('n', '<leader>ta', neotest.run.attach, { desc = 'Attach to running test' })
  end,
}
