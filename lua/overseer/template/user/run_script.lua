local get_cmd = function(file, dest_path, dest_file)
  local cmd = {}
  -- go
  if vim.bo.filetype == 'go' then
    cmd = { 'go', 'run', file }

    -- python
  elseif vim.bo.filetype == 'python' then
    -- check which os, based on that run different command

    if vim.uv.os_uname().sysname == 'Linux' then
      cmd = { 'python3' }
    else
      cmd = { 'py' }
    end
    table.insert(cmd, file)
  elseif vim.bo.filetype == 'asm' then
    -- cmd = { 'nasm', '-f', 'elf64' }
    return 'gcc -no-pie -o ' .. dest_path .. ' ' .. file .. ' && ' .. dest_path
  end
  return cmd
end

return {
  name = 'run script',
  builder = function()
    -- default config
    local file = vim.fn.expand '%:p'
    local file_name = vim.fn.expand '%:r'
    local dest_path = vim.fn.expand '%:p:r'
    local cmd = get_cmd(file, dest_path, file_name)

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
    filetype = { 'sh', 'python', 'go', 'asm' },
  },
}
