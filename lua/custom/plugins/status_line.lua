--------------- Utilities ----------------
--- https://github.com/nvim-tree/nvim-web-devicons

local nvim_web_devicons = {
  'nvim-tree/nvim-web-devicons',
  config = function()
    require('nvim-web-devicons').setup {
      -- your personal icons can go here (to override)
      -- you can specify color or cterm_color instead of specifying both of them
      -- DevIcon will be appended to `name`
      override = {
        zsh = {
          icon = '',
          color = '#428850',
          cterm_color = '65',
          name = 'Zsh',
        },
      },
      -- globally enable different highlight colors per icon (default to true)
      -- if set to false all icons will have the default icon's color
      color_icons = true,
      -- globally enable default icons (default to false)
      -- will get overriden by `get_icons` option
      default = true,
      -- globally enable "strict" selection of icons - icon will be looked up in
      -- different tables, first by filename, and if not found by extension; this
      -- prevents cases when file doesn't have any extension but still gets some icon
      -- because its name happened to match some extension (default to false)
      strict = true,
      -- set the light or dark variant manually, instead of relying on `background`
      -- (default to nil)
      variant = 'light|dark',
      -- same as `override` but specifically for overrides by filename
      -- takes effect when `strict` is true
      override_by_filename = {
        ['.gitignore'] = {
          icon = ' ',
          color = '#f1502f',
          name = 'Gitignore',
        },
      },
      -- same as `override` but specifically for overrides by extension
      -- takes effect when `strict` is true
      override_by_extension = {
        ['log'] = {
          icon = ' ',
          color = '#81e043',
          name = 'Log',
        },
      },
      -- same as `override` but specifically for operating system
      -- takes effect when `strict` is true
      override_by_operating_system = {
        ['apple'] = {
          icon = ' ',
          color = '#A2AAAD',
          cterm_color = '248',
          name = 'Apple',
        },
      },
    }
  end,
  opts = {},
  priority = 1000,
}

--------------- Status Bar ------------
---
--- https://github.com/b0o/incline.nvim?tab=readme-ov-file
local status_bar_config = function()
  local devicons = require 'nvim-web-devicons'
  require('incline').setup {
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      if filename == '' then
        filename = '[No Name]'
      end
      local ft_icon, ft_color = devicons.get_icon_color(filename)

      local function get_git_diff()
        local icons = { removed = ' ', changed = ' ', added = ' ' }
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { '┊ ' })
        end
        return labels
      end

      local function get_diagnostic_label()
        local icons = { error = '  ', warn = '  ', info = '  ', hint = '  ' }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
            table.insert(label, { icon .. n .. ' ', group = 'DiagnosticSign' .. severity })
          end
        end
        if #label > 0 then
          table.insert(label, { '┊ ' })
        end
        return label
      end

      return {
        { get_diagnostic_label() },
        { get_git_diff() },
        { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
        { filename .. ' ', gui = vim.bo[props.buf].modified and 'bold,italic' or 'bold' },
        { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' },
      }
    end,
  }
end

local status_bar_config_1 = function()
  require('incline').setup {
    render = function(props)
      local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ':t')
      local ft_icon, ft_color = require('nvim-web-devicons').get_icon_color(filename)
      local modified = vim.bo[props.buf].modified and 'bold,italic' or 'bold'

      local function get_git_diff()
        local icons = { removed = ' ', changed = ' ', added = ' ' }
        icons['changed'] = icons.modified
        local signs = vim.b[props.buf].gitsigns_status_dict
        local labels = {}
        if signs == nil then
          return labels
        end
        for name, icon in pairs(icons) do
          if tonumber(signs[name]) and signs[name] > 0 then
            table.insert(labels, { icon .. signs[name] .. ' ', group = 'Diff' .. name })
          end
        end
        if #labels > 0 then
          table.insert(labels, { '┊ ' })
        end
        return labels
      end
      local function get_diagnostic_label()
        local icons = { error = '', warn = '', info = '', hint = '' }
        local label = {}

        for severity, icon in pairs(icons) do
          local n = #vim.diagnostic.get(props.buf, { severity = vim.diagnostic.severity[string.upper(severity)] })
          if n > 0 then
          end
        end
        if #label > 0 then
          table.insert(label, { '┊ ' })
        end
        return label
      end

      local buffer = {
        { get_diagnostic_label() },
        { get_git_diff() },
        { (ft_icon or '') .. ' ', guifg = ft_color, guibg = 'none' },
        { filename .. ' ', gui = modified },
        { '┊  ' .. vim.api.nvim_win_get_number(props.win), group = 'DevIconWindows' },
      }
      return buffer
    end,
  }
end

local status_bar = {
  'b0o/incline.nvim',
  config = status_bar_config,
}
local status_bar_1 = {
  'b0o/incline.nvim',
  config = status_bar_config_1,
}

--------------Config Return -------------

return {
  status_bar,
}
