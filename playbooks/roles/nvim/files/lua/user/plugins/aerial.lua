---@type LazySpec
return {
  "stevearc/aerial.nvim",
  event = "VeryLazy",
  -- for all available options, refer to: `:help aerial-options`
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    icons = require("user.icons").LspKind,
    disable_max_lines = vim.g.max_file.lines,
    disable_max_size = vim.g.max_file.size,
    filter_kind = false,
    show_guides = true,
    attach_mode = "global",
  },
  config = function(_, opts)
    require("aerial").setup(opts)
    require("which-key").register({
      ls = { "<cmd>AerialToggle<cr>", "Show symbols outline" },
    }, { prefix = "<leader>" })
  end,
}