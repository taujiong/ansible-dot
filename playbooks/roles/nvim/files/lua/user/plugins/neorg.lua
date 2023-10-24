---@type LazySpec
return {
  "nvim-neorg/neorg",
  build = ":Neorg sync-parsers",
  ft = { "norg" },
  cmd = { "Neorg" },
  keys = {
    { "<leader>ni", "<cmd>Neorg index<cr>", desc = "Open Neorg entry for current workspace" },
    { "<leader>nq", "<cmd>Neorg return<cr>", desc = "Quit all neorg buffers" },
  },
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
    ---@diagnostic disable-next-line: missing-fields
    require("cmp").setup.filetype("norg", {
      sources = {
        { name = "neorg", priority = 725 },
      },
    })
  end,
}
