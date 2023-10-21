local M = {}

local function bool2str(bool)
  return bool and "on" or "off"
end

function M.toggle_global_autoformat()
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  vim.notify(string.format("Global autoformatting %s", bool2str(vim.g.autoformat_enabled)))
end

function M.toggle_buffer_autoformat(bufnr)
  bufnr = bufnr or 0
  local old_val = vim.b[bufnr].autoformat_enabled
  if old_val == nil then
    old_val = vim.g.autoformat_enabled
  end
  vim.b[bufnr].autoformat_enabled = not old_val
  vim.notify(string.format("Buffer autoformatting %s", bool2str(vim.b[bufnr].autoformat_enabled)))
end

function M.toggle_relative_number()
  vim.wo.relativenumber = not vim.wo.relativenumber
  vim.notify(string.format("Relative number %s", bool2str(vim.wo.relativenumber)))
end

function M.toggle_wrap()
  vim.wo.wrap = not vim.wo.wrap
  vim.notify(string.format("wrap %s", bool2str(vim.wo.wrap)))
end

function M.toggle_buffer_inlay_hints(bufnr)
  bufnr = bufnr or 0
  vim.b[bufnr].inlay_hints_enabled = not vim.b[bufnr].inlay_hints_enabled
  vim.lsp.inlay_hint(bufnr, vim.b[bufnr].inlay_hints_enabled)
  vim.notify(string.format("Inlay hints %s", bool2str(vim.b[bufnr].inlay_hints_enabled)))
end

function M.toggle_cmp()
  vim.g.cmp_enabled = not vim.g.cmp_enabled
  vim.notify(string.format("completion %s", bool2str(vim.g.cmp_enabled)))
end

function M.toggle_autopairs()
  local autopairs = require("nvim-autopairs")
  if autopairs.state.disabled then
    autopairs.enable()
  else
    autopairs.disable()
  end
  vim.notify(string.format("autopairs %s", bool2str(not autopairs.state.disabled)))
end

return M
