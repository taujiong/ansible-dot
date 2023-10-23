---@type LazySpec
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "norg" },
  cmd = { "Neorg" },
  opts = {
    load = {
      -- https://github.com/nvim-neorg/neorg/wiki/Defaults
      ["core.defaults"] = {
        config = {
          disable = {
            "core.journal",
          },
        },
      },
      -- https://github.com/nvim-neorg/neorg/wiki/Concealer
      ["core.concealer"] = {},
      -- https://github.com/nvim-neorg/neorg/wiki/Dirman
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
      -- https://github.com/nvim-neorg/neorg/wiki/Defaults
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
    },
  },
  config = function(_, opts)
    require("neorg").setup(opts)
    require("cmp").setup.filetype("norg", {
      sources = {
        { name = "neorg", priority = 725 },
      },
    })
  end,
  init = function()
    require("which-key").register({
      n = {
        name = require("user.icons").WhichKeyPrefix.Neoorg .. " Neorg",
        i = { "<cmd>Neorg index<cr>", "Open Neorg entry for current workspace" },
        q = { "<cmd>Neorg return<cr>", "Quit all neorg buffers" },
      },
    }, { prefix = "<leader>" })
  end,
}
