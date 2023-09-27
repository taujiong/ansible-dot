---@type LazySpec
return {
  "gbprod/substitute.nvim",
  event = "BufEnter",
  -- for all available options, refer to `:help substitute-nvim-table-of-contents`
  opts = {},
  config = function(_, opts)
    require("substitute").setup(opts)
    require("which-key").register({
      s = { require("substitute").operator, "Replace with {motion}", },
      ss = { require("substitute").line, "Replace with line", },
      p = { require("substitute").visual, "Replace in visual", mode = "v", },
      sx = { require("substitute.exchange").operator, "Exchange with {motion}", },
      sxx = { require("substitute.exchange").line, "Exchange with line", },
      sxc = { require("substitute.exchange").cancel, "Exchange exchange", },
      X = { require("substitute.exchange").visual, "Exchange in visual", mode = "v", },
    })
  end,
}
