---@type LazySpec
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  dependencies = { "nvim-lua/plenary.nvim" },
  ft = { "norg" },
  cmd = { "Neorg" },
  -- for all available options, refer to: `:help `
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
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          workspaces = {
            notes = "~/notes",
          },
          default_workspace = "notes",
        },
      },
    },
  },
}
