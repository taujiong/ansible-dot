---@type LazySpec
return {
  "chentoast/marks.nvim",
  event = "VeryLazy",
  -- for all available options, refer to `:help marks-setup`
  opts = {
    default_mappings = false,
  },
  config = function(_, opts)
    require("marks").setup(opts)
    require("which-key").register({
      dm = {
        name = "marks",
        l = { require("marks").delete_line, "Delete marks on current line", },
        f = { require("marks").delete_buf, "Delete marks on current file", },
      },
      m = {
        name = "Marks",
        m = { require("marks").toggle, "Toggle mark", },
        ["["] = { require("marks").prev, "Go to previous mark", },
        ["]"] = { require("marks").next, "Go to next mark", },
      },
    })
  end,
}
