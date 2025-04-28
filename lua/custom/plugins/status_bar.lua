local status_bar_config = function()
  require('lualine').setup {
    options = {
      icons_enabled = true,
      theme = 'auto',
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      ignore_focus = {},
      always_divide_middle = true,
      always_show_tabline = true,
      globalstatus = false,
      refresh = {
        statusline = 100,
        tabline = 100,
        winbar = 100,
      },
    },
    sections = {
      lualine_a = { 'mode' },
      lualine_b = { 'branch', 'filesize' }, -- 'diff', 'diagnostics'
      lualine_c = { 'lsp_status' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = { 'location' },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { 'filename' },
      lualine_x = { 'location' },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    winbar = {},
    inactive_winbar = {},
    extensions = {},
  }
end

local colors = {
  blue = '#80a0ff',
  cyan = '#79dac8',
  black = '#080808',
  white = '#c6c6c6',
  red = '#ff5189',
  violet = '#d183e8',
  grey = '#303030',
  orange = '#f57b42',
  light_green = '#42f554',
  aqua = '#42f5b0',
  yellow = '#f5d742',
}

local bubbles_theme = {
  normal = {
    a = { fg = colors.black, bg = colors.violet },
    b = { fg = colors.yellow, bg = colors.grey },
    c = { fg = colors.aqua },
  },

  insert = { a = { fg = colors.black, bg = colors.blue } },
  visual = { a = { fg = colors.black, bg = colors.cyan } },
  replace = { a = { fg = colors.black, bg = colors.red } },

  inactive = {
    a = { fg = colors.white, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.white },
  },
}
local cell_left = {
  function()
    return ''
  end,
  separator = {},
}

local cell_right = {
  function()
    return ''
  end,
  separator = {},
}

local status_bar_bubbles = function()
  require('lualine').setup {
    options = {
      theme = bubbles_theme,
      component_separators = { left = '', right = '' },
      section_separators = { left = '', right = '' },
    },
    sections = {
      lualine_a = {
        { 'mode', separator = { left = '', right = '' }, right_padding = 2 },
      },
      lualine_b = { 'filesize', 'lsp_status' },
      -- lualine_c = { { '%=', separator = { right = '' } }, cell_left, { 'branch', separator = { left = '', right = '' } }, cell_right },
      lualine_c = { 'overseer', 'branch' },
      lualine_x = { 'encoding', 'fileformat', 'filetype' },
      lualine_y = { 'progress' },
      lualine_z = {
        { 'location', separator = { left = '', right = '' }, left_padding = 2 },
      },
    },
    inactiove = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = {},
      lualine_x = {},
      lualine_y = {},
      lualine_z = {},
    },
  }
end

local status_line = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = status_bar_config,
}

local status_line_bubble = {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = status_bar_bubbles,
}

return status_line_bubble
