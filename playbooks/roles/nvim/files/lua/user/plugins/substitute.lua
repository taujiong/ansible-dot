---@type LazySpec
return {
  "gbprod/substitute.nvim",
  event = { "BufEnter" },
  keys = {
    {
      "s",
      function()
        require("substitute").operator()
      end,
      desc = "Replace with {motion}",
    },
    {
      "ss",
      function()
        require("substitute").line()
      end,
      desc = "Replace with line",
    },
    {
      "p",
      function()
        require("substitute").visual()
      end,
      desc = "Replace in visual",
      mode = "v",
    },
    {
      "sx",
      function()
        require("substitute.exchange").operator()
      end,
      desc = "Exchange with {motion}",
    },
    {
      "sxx",
      function()
        require("substitute.exchange").line()
      end,
      desc = "Exchange with line",
    },
    {
      "sxc",
      function()
        require("substitute.exchange").cancel()
      end,
      desc = "Exchange exchange",
    },
    {
      "X",
      function()
        require("substitute.exchange").visual()
      end,
      desc = "Exchange in visual",
      mode = "v",
    },
  },
  -- for all available options, refer to `:help substitute-nvim-table-of-contents`
  opts = {},
}
