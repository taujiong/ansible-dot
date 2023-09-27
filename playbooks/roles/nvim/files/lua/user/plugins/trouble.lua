---@type LazySpec
return {
  "folke/trouble.nvim",
  event = "VeryLazy",
  -- for all available options, refer to: `:help trouble.nvim-trouble-configuration`
  ---@type TroubleOptions
  opts = {
    use_diagnostic_signs = true,
  },
}
