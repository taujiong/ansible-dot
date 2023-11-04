---@type LazySpec
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "folke/neoconf.nvim",
    "folke/neodev.nvim",
  },
  event = { "BufEnter" },
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
    mason = {
      log_level = vim.log.levels.WARN,
      ui = {
        border = "rounded",
        height = 0.8,
      },
    },
    ---@type MasonLspconfigSettings
    mason_lspconfig = {
      automatic_installation = true,
      ensure_installed = {
        "ansiblels",
        "eslint",
        "jsonls",
        "lua_ls",
        "tsserver",
        "yamlls",
      },
    },
  },
  config = function(_, opts)
    require("neoconf").setup(opts.neoconf)
    require("neodev").setup(opts.neodev)
    require("mason").setup(opts.mason)
    require("mason-lspconfig").setup(opts.mason_lspconfig)
    require("user.utils.lsp").setup()
  end,
}
