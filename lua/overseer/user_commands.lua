vim.api.nvim_create_user_command('DebugFloat', function()
  local overseer = require 'overseer'
  overseer.run_template({ name = 'run script' }, function(task)
    if task then
      local main_win = vim.api.nvim_get_current_win()
      overseer.run_action(task, 'open float')
      --vim.api.nvim_set_current_win(main_win)
    else
      vim.notify('Not supported file type ' .. vim.bo.filetype, vim.log.levels.ERROR)
    end
  end)
end, {})
