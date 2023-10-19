---@type LazySpec
return {
  "stevearc/dressing.nvim",
  event = "VeryLazy",
  -- for all available options, refer to `:help dressing-configuration`
  opts = {
    input = {
      default_prompt = require("user.icons").UI.Selected .. " ",
    },
    select = {
      backend = { "telescope", "nui", "builtin" },
    },
  },
}
