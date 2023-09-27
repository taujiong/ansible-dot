---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  -- for all available options, refer to `:help catppuccin-configuration`
  ---@type CatppuccinOptions
  opts = {
    transparent_background = true,
    flavour = "frappe",
    term_colors = true,
    integrations = {
      aerial = false,
      cmp = true,
      dap = {
        enabled = false,
        enable_ui = false,
      },
      flash = true,
      gitsigns = true,
      lsp_trouble = true,
      markdown = true,
      mason = true,
      mini = true,
      native_lsp = {
        enabled = true,
      },
      neogit = true,
      neotest = false,
      noice = true,
      nvimtree = true,
      telescope = {
        enabled = true,
        style = "nvchad",
      },
      ufo = true,
      which_key = true,
    },
  },
}
