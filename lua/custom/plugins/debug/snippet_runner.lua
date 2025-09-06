--https://github.com/michaelb/sniprun

-- sniprun does not work on windows, so check
if vim.uv.os_uname().sysname == 'Linux' then
  return {
    'michaelb/sniprun',
    branch = 'master',

    build = 'sh install.sh',
    config = function()
      require('sniprun').setup {
        display = { 'NvimNotify' },
        display_options = {
          notification_timeout = 5,
        },
      }

      -- Setting bindings for sniprun
      -- vim.api.nvim_set_keymap('n', '<leader>f', '<Plug>SnipRunOperator', { silent = true })
    end,
  }
end

return {}
