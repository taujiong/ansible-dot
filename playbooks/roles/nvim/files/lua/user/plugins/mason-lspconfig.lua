---@type LazySpec
return {
  "williamboman/mason-lspconfig.nvim",
  dependencies = {
    "williamboman/mason.nvim",
    "neovim/nvim-lspconfig",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
    "b0o/SchemaStore.nvim",
  },
  ---@type MasonLspconfigSettings
  opts = {
    automatic_installation = true,
    ensure_installed = {
      "lua_ls",
      "jsonls",
      "yamlls",
    },
  },
  config = function(_, opts)
    require("neodev").setup()
    require("neoconf").setup({
      plugins = {
        lua_ls = {
          enabled = true,
        },
      },
    })
    require("mason").setup()
    require("mason-lspconfig").setup(opts)
    require("user.lsp").setup()
  end,
}
