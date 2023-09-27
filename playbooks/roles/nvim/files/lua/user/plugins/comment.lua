---@type LazySpec
return {
  "numToStr/Comment.nvim",
  event = "BufEnter",
  dependencies = {
    "JoosepAlviste/nvim-ts-context-commentstring",
  },
  -- for all available options, refer to `:help comment.config`
  opts = {},
  config = function(_, opts)
    require("Comment").setup(vim.tbl_deep_extend("force", {
      pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
    }, opts))
    require("which-key").register({
      ["<c-/>"] = {
        function()
          require("Comment.api").toggle.linewise.count(vim.v.count > 0 and vim.v.count or 1)
        end,
        "Toggle comment line",
      },
    })
    require("which-key").register({
      ["<c-/>"] = {
        function()
          require('Comment.api').toggle.linewise(vim.fn.visualmode())
        end,
        "Toggle comment for selection",
      },
    }, { mode = "v", })
  end,
}
