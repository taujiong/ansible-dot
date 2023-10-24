---@type LazySpec
return {
  "nguyenvukhang/nvim-toggler",
  keys = {
    {
      "<leader>i",
      function()
        require("nvim-toggler").toggle()
      end,
      desc = "Toggle cursor word",
    },
  },
  -- for all available options, refer to `:help nvim-toggler-nvim-toggler`
  opts = {
    inverses = {
      ["True"] = "False",
      ["good"] = "bad",
    },
  },
}
