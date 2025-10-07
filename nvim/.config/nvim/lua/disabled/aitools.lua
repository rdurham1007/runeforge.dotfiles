return {
  {
    'zbirenbaum/copilot.lua',
    cmd = 'Copilot',
    build = ':Copilot auth',
    event = 'InsertEnter',
    config = function()
      require('copilot').setup {
        suggestion = { enabled = true },
        panel = { enabled = true },
      }
    end,
  },
  -- {
  --   'giuxtaposition/blink-cmp-copilot',
  --   dependencies = { 'copilot.lua' },
  -- },
  {
    'olimorris/codecompanion.nvim',
    event = 'VeryLazy',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-treesitter/nvim-treesitter',
      'stevearc/dressing.nvim',
    },
    cmd = 'CodeCompanion',
    config = function()
      require('codecompanion').setup {
        strategies = {
          inline = {
            keymaps = {
              accept_change = {
                modes = { n = 'cca' },
                description = 'Accept the suggested change',
              },
              reject_change = {
                modes = { n = 'ccr' },
                description = 'Reject the suggested change',
              },
            },
          },
        },
        adapter = 'copilot',
        display = {
          inline = {
            layout = 'buffer', -- vertical|horizontal|buffer
          },
        },
      }
      vim.keymap.set({ 'n', 'v' }, '<leader>ci', '<cmd>CodeCompanion<CR>', { desc = 'Toggle CodeCompanion Chat' })
      vim.keymap.set('n', '<leader>cc', '<cmd>CodeCompanionChat Toggle<CR>', { desc = 'Toggle CodeCompanion Chat' })
      vim.keymap.set('n', '<leader>ca', '<cmd>CodeCompanionActions<CR>', { desc = 'CodeCompanion Actions' })
    end,
  },
}
