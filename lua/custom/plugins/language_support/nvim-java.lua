return {
  'nvim-java/nvim-java',
  lazy = false,
  dependencies = {
    'nvim-java/lua-async-await',
    'nvim-java/nvim-java-core',
    'nvim-java/nvim-java-test',
    'nvim-java/nvim-java-dap',
    'MunifTanjim/nui.nvim',
    'neovim/nvim-lspconfig',
    'mfussenegger/nvim-dap',
    {
      'williamboman/mason.nvim',
      opts = {
        registries = {
          'github:nvim-java/mason-registry',
          'github:mason-org/mason-registry',
        },
      },
    },
  },
  config = function()
    require('java').setup {
      jdk = {
        auto_install = false,
      },
      settings = {
        java = {
          configuration = {
            runtimes = {
              {
                name = 'JavaSE-21',
                path = '/usr/lib/jvm/default-runtime',
                default = true,
              },
            },
          },
        },
      },
    }
    require('lspconfig').jdtls.setup {
      -- lsp settings
    }
  end,
}
