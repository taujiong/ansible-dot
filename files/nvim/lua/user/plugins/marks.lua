---@type LazySpec
return {
  "chentoast/marks.nvim",
  keys = {
    {
      "dml",
      function()
        require("marks").delete_line()
      end,
      desc = "Delete marks on current line",
    },
    {
      "dmf",
      function()
        require("marks").delete_buf()
      end,
      desc = "Delete marks on current file",
    },
    {
      "mm",
      function()
        require("marks").toggle()
      end,
      desc = "Toggle mark",
    },
    {
      "m[",
      function()
        require("marks").prev()
      end,
      desc = "Go to previous mark",
    },
    {
      "m]",
      function()
        require("marks").next()
      end,
      desc = "Go to next mark",
    },
  },
  -- for all available options, refer to `:help marks-setup`
  opts = {
    default_mappings = false,
  },
}
