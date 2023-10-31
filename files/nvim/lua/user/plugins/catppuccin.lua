---@type LazySpec
return {
  "catppuccin/nvim",
  name = "catppuccin",
  priority = 1000,
  -- for all available options, refer to `:help catppuccin-configuration`
  ---@type CatppuccinOptions
  opts = {
    flavour = "frappe",
    transparent_background = true,
    term_colors = true,
    styles = {
      conditionals = {},
    },
    integrations = {
      aerial = true,
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
      mini = {
        enabled = true,
      },
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
      treesitter = true,
      ufo = true,
      which_key = true,
    },
  },
}
