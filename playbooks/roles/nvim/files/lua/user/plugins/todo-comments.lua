---@type LazySpec
return {
  "folke/todo-comments.nvim",
  event = "VeryLazy",
  -- for all available options, refer to `:help todo-comments.nvim-todo-comments-configuration`
  ---@type TodoOptions
  opts = {},
  config = function(_, opts)
    require("todo-comments").setup(opts)
    require("which-key").register({
      ["<leader>ft"] = { "<cmd>TodoTelescope<cr>", "Find todos" },
      ["[t"] = { require("todo-comments").jump_prev, "Previous todo comment" },
      ["]t"] = { require("todo-comments").jump_next, "Next todo comment" },
    })
  end,
}
