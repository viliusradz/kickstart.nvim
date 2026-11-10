-- https://github.com/mrcjkb/rustaceanvim

vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr) end,
    default_settings = {
      ['rust-analyzer'] = {},
    },
  },
  --- @type rustaceanvim.dap.opts
  dap = {},
}
vim.keymap.set('n', '<leader>dRr', function()
  vim.cmd.RustLsp 'runnables'
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { desc = '[R]un [R]ust' })
vim.keymap.set('n', '<leader>dRd', function()
  vim.cmd.RustLsp 'debuggables'
  -- or vim.lsp.buf.codeAction() if you don't want grouping.
end, { desc = '[D]ebug [R]ust' })
return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
}
