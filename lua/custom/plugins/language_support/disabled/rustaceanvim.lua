-- https://github.com/mrcjkb/rustaceanvim

vim.g.rustaceanvim = {
  server = {
    on_attach = function(client, bufnr) end,
    default_settings = {
      ['rust-analyzer'] = {},
    },
  },
}
return {
  'mrcjkb/rustaceanvim',
  version = '^6',
  lazy = false,
}
