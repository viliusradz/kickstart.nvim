vim.api.nvim_set_keymap('v', '<leader>ps', '<Plug>SnipRun', { silent = true })
vim.api.nvim_set_keymap('n', '<leader>ps', '<Plug>SnipRun', { silent = true })

vim.keymap.set('n', '<leader>pr', function()
  local overseer = require 'overseer'
  overseer.run_template({ name = 'run script', silent = true }, function(task)
    overseer.run_action(task, 'open hsplit')
  end)
end, { silent = true, desc = 'Overseer Run' })

vim.keymap.set('n', '<leader>pu', function()
  local overseer = require 'overseer'
  overseer.toggle { enter = true, direction = 'bottom' }
end, { silent = true, desc = 'Overseer Toggle' })
