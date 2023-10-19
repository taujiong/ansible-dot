---@type LazySpec
return {
  "nguyenvukhang/nvim-toggler",
  event = { "BufEnter" },
  -- for all available options, refer to `:help nvim-toggler-nvim-toggler`
  opts = {
    inverses = {
      ["True"] = "False",
      ["good"] = "bad",
    },
  },
  config = function(_, opts)
    require("nvim-toggler").setup(opts)
    require("which-key").register({
      ["<leader>i"] = { desc = "Toggle cursor word" },
    })
  end,
}
