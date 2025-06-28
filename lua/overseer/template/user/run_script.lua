local get_cmd = function()
  local cmd = {}
  -- go
  if vim.bo.filetype == 'go' then
    cmd = { 'go', 'run' }

    -- python
  elseif vim.bo.filetype == 'python' then
    -- check which os, based on that run different command

    if vim.uv.os_uname().sysname == 'Linux' then
      cmd = { 'python3' }
    else
      cmd = { 'py' }
    end
  elseif vim.bo.filetype == 'asm' then
    cmd = { 'nasm', '-f', 'elf64' }
  end
  return cmd
end

return {
  name = 'run script',
  builder = function()
    -- default config
    local file = vim.fn.expand '%:p'
    local cmd = get_cmd()
    table.insert(cmd, file)

    return {
      cmd = cmd,
      components = {
        { 'on_output_quickfix', set_diagnostics = true },
        'on_result_diagnostics',
        'default',
        'open_output',
      },
    }
  end,
  condition = {
    filetype = { 'sh', 'python', 'go' },
  },
}
