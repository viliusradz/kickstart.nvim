return {
  'xiyaowong/transparent.nvim',
  config = function()
    require('transparent').setup {
      exclude = {
        'WinSeparator',
      },
    }
    -- require('transparent').clear_prefix 'NeoTree'
  end,
}
