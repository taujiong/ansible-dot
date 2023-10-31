local M = {}

function M.prepare()
  require("user.options")
  require("user.utils.lsp").setup_vim_diagnostic()
end

function M.polish()
  vim.cmd.colorscheme("catppuccin")
  require("user.autocmds")
end

return M
