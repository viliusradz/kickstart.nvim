local get_assembly_files
get_assembly_files = function(base_dir)
  local dir = vim.fn.readdir(base_dir)
  local assembly_files = {}
  for _, v in pairs(dir) do
    local child = base_dir .. '/' .. v
    if vim.fn.isdirectory(child) == 1 then
      for _, sub_file in pairs(get_assembly_files(child)) do
        table.insert(assembly_files, sub_file)
      end
    else
      local last_elem = ''
      for elem in string.gmatch(child, '([^' .. '/' .. ']+)') do
        last_elem = elem
      end
      if string.find(last_elem, '.s') then
        table.insert(assembly_files, child)
      end
    end
  end
  return assembly_files
end

local get_cmd = function(file, dest_path)
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
    -- vim.fn.expand ''
    local cwd = vim.fn.getcwd()
    local asm_files = get_assembly_files(cwd)

    dest_path = cwd .. '/' .. 'program'
    return 'gcc -no-pie -o ' .. dest_path .. ' ' .. table.concat(asm_files, ' ') .. ' && ' .. dest_path
  end
  return cmd
end

return {
  name = 'run script',
  builder = function()
    -- default config
    local file = vim.fn.expand '%:p'
    local dest_path = vim.fn.expand '%:p:r'
    local cmd = get_cmd(file, dest_path)

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
