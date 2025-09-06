-- https://github.com/rcarriga/nvim-notify

return {
  'rcarriga/nvim-notify',
  confing = function()
    require('nvim-notify').setup {
      background_colour = 'NotifyBackground',
      fps = 60,
      icons = {
        DEBUG = ' ',
        ERROR = ' ',
        INFO = ' ',
        TRACE = '✎ ',
        WARN = ' ',
      },
      level = 2,
      minimum_width = 20,
      render = 'default',
      stages = 'slide',
      time_formats = {
        notification = '%T',
        notification_history = '%FT%T',
      },
      timeout = 5000,
      top_down = true,
    }
    vim.notify = require('notify').notify
  end,
  priority = 1900,
}
