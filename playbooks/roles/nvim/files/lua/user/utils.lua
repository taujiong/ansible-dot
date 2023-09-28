local M = {}

local function setup_vim_diagnostic()
  local icons = require("user.icons")
  local signs = {
    { name = "DiagnosticSignError", text = icons.Diagnostic.Error, texthl = "DiagnosticSignError", },
    { name = "DiagnosticSignWarn",  text = icons.Diagnostic.Warn,  texthl = "DiagnosticSignWarn", },
    { name = "DiagnosticSignInfo",  text = icons.Diagnostic.Info,  texthl = "DiagnosticSignInfo", },
    { name = "DiagnosticSignHint",  text = icons.Diagnostic.Hint,  texthl = "DiagnosticSignHint", },
  }
  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, sign)
  end
  vim.diagnostic.config({
    update_in_insert = true,
    underline = false,
    severity_sort = true,
    float = {
      focused = false,
      border = "rounded",
      source = "always",
    },
  })
end

function M.pre_lazy()
  require("user.options")
  setup_vim_diagnostic()
end

function M.post_lazy()
  vim.cmd.colorscheme("catppuccin")
  require("user.autocmds")
end

function M.open_with_system(path)
  local cmd
  if vim.fn.has("win32") == 1 and vim.fn.executable("explorer") == 1 then
    cmd = { "cmd.exe", "/K", "explorer", }
  elseif vim.fn.has("unix") == 1 and vim.fn.executable("xdg-open") == 1 then
    cmd = { "xdg-open", }
  elseif (vim.fn.has("mac") == 1 or vim.fn.has("unix") == 1) and vim.fn.executable("open") == 1 then
    cmd = { "open", }
  end
  if not cmd then
    vim.notify("Available system opening tool not found!", vim.log.levels.ERROR)
  end
  vim.fn.jobstart(vim.fn.extend(cmd, { path or vim.fn.expand("<cfile>"), }), { detach = true, })
end

return M
