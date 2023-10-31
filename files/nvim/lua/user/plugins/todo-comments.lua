---@type LazySpec
return {
  "folke/todo-comments.nvim",
  event = { "BufEnter" },
  keys = {
    { "<leader>ft", "<cmd>TodoTelescope<cr>", desc = "Find todos" },
    {
      "[t",
      function()
        require("todo-comments").jump_prev()
      end,
      desc = "Previous todo comment",
    },
    {
      "]t",
      function()
        require("todo-comments").jump_next()
      end,
      desc = "Next todo comment",
    },
  },
  -- for all available options, refer to `:help todo-comments.nvim-todo-comments-configuration`
  ---@type TodoOptions
  opts = {},
}
