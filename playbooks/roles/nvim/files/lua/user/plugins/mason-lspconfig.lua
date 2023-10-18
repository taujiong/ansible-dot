---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
    "b0o/SchemaStore.nvim",
  },
  opts = {
    ---@type LuaDevOptions
    neodev = {},
    ---@type Config
    neoconf = {
      plugins = {
        lua_ls = {
          enabled = true,
        },
      },
    },
    ---@type MasonSettings
    mason = {},
    ---@type MasonLspconfigSettings
    mason_lspconfig = {
      automatic_installation = true,
      ensure_installed = {
        "eslint",
        "jsonls",
        "lua_ls",
        "tsserver",
        "yamlls",
      },
    },
  },
  config = function(_, opts)
    require("neodev").setup(opts.neodev)
    require("neoconf").setup(opts.neoconf)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("user.utils.lsp").setup()
  end,
}
