-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information

-- vim.api.nvim_create_autocmd('FileType', {
--   pattern = 'cs',
--   callback = function()
--     vim.opt_local.makeprg = 'dotnet build --nologo -warnaserror:false'
--     vim.opt_local.errorformat = '%f(%l\\,%c): %t%*[^:]: %m'
--   end,
-- })

-- Toggle quickfix window
vim.keymap.set('n', '<leader>qo', '<cmd>copen<CR>', { desc = 'Open Quickfix' })
vim.keymap.set('n', '<leader>qc', '<cmd>cclose<CR>', { desc = 'Close Quickfix' })
vim.keymap.set('n', '<leader>qn', '<cmd>cnext<CR>', { desc = 'Next Quickfix Item' })
vim.keymap.set('n', '<leader>qp', '<cmd>cprev<CR>', { desc = 'Previous Quickfix Item' })
return {
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = { 'markdown', 'codecompanion' },
  },
  {
    'christoomey/vim-tmux-navigator',
    cmd = {
      'TmuxNavigateLeft',
      'TmuxNavigateDown',
      'TmuxNavigateUp',
      'TmuxNavigateRight',
      'TmuxNavigatePrevious',
      'TmuxNavigatorProcessList',
    },
    keys = {
      { '<c-h>', '<cmd><C-U>TmuxNavigateLeft<cr>' },
      { '<c-j>', '<cmd><C-U>TmuxNavigateDown<cr>' },
      { '<c-k>', '<cmd><C-U>TmuxNavigateUp<cr>' },
      { '<c-l>', '<cmd><C-U>TmuxNavigateRight<cr>' },
      { '<c-\\>', '<cmd><C-U>TmuxNavigatePrevious<cr>' },
    },
  },
}
