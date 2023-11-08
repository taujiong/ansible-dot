---@type LazySpec
return {
  "mrjones2014/smart-splits.nvim",
  lazy = false,
  keys = {
    {
      "<c-h>",
      function()
        require("smart-splits").move_cursor_left()
      end,
      "Go to left window",
    },
    {
      "<c-j>",
      function()
        require("smart-splits").move_cursor_down()
      end,
      "Go to lower window",
    },
    {
      "<c-k>",
      function()
        require("smart-splits").move_cursor_up()
      end,
      "Go to upper window",
    },
    {
      "<c-l>",
      function()
        require("smart-splits").move_cursor_right()
      end,
      "Go to right window",
    },
    {
      "<m-h>",
      function()
        require("smart-splits").resize_left()
      end,
      "move split to left",
    },
    {
      "<m-j>",
      function()
        require("smart-splits").resize_down()
      end,
      "move split to down",
    },
    {
      "<m-k>",
      function()
        require("smart-splits").resize_up()
      end,
      "move split to up",
    },
    {
      "<m-l>",
      function()
        require("smart-splits").resize_right()
      end,
      "move split to right",
    },
  },
  -- for all available options, refer to: `:help smart-splits`
  opts = {
    at_edge = "stop",
    resize_mode = {
      silent = true,
    },
  },
}
