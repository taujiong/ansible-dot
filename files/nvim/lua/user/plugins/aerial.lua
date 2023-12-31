---@type LazySpec
return {
  "stevearc/aerial.nvim",
  event = { "BufEnter" },
  keys = {
    { "<leader>ls", "<cmd>AerialToggle<cr>", desc = "Show symbols outline" },
  },
  -- for all available options, refer to: `:help aerial-options`
  opts = {
    backends = { "lsp", "treesitter", "markdown", "man" },
    icons = require("user.icons").LspKind,
    disable_max_lines = vim.g.max_file.lines,
    disable_max_size = vim.g.max_file.size,
    autojump = true,
    filter_kind = false,
    show_guides = true,
    attach_mode = "global",
    layout = {
      max_width = { 60, 0.4 },
      min_width = { 40, 0.2 },
    },
  },
}
