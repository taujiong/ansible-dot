---@type LazySpec
return {
  "folke/flash.nvim",
  event = "BufEnter",
  -- for all available options, refer to `:help flash.nvim-flash.nvim-configuration`
  ---@type Flash.Config
  opts = {
    search = {
      multi_window = false,
    },
    modes = {
      char = { enabled = false },
    },
    prompt = {
      enabled = false,
    },
  },
  config = function(_, opts)
    require("flash").setup(opts)
    vim.api.nvim_set_hl(0, "FlashMatch", { fg = "#89b4fa", bold = true, italic = true })
    vim.api.nvim_set_hl(0, "FlashCurrent", { fg = "#04a5e5", bold = true, italic = true, underline = true })
    vim.api.nvim_set_hl(0, "FlashLabel", { fg = "#ff007c", bold = true })
    vim.api.nvim_set_hl(0, "FlashBackdrop", { fg = "#6c7086" })
  end,
}
