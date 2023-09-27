---@type LazySpec
return {
  "NeogitOrg/neogit",
  event = "VeryLazy",
  -- for all available options, refer to `:help `
  opts = {},
  config = function(_, opts)
    require("neogit").setup(opts)
    require("which-key").register({
      ["<leader>gg"] = { require("neogit").open, "Open neogit", },
    })
  end,
}
