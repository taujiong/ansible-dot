local M = {}

local function bool2str(bool) return bool and "on" or "off" end

function M.toggle_global_autoformat()
  vim.g.autoformat_enabled = not vim.g.autoformat_enabled
  vim.notify(string.format("Global autoformatting %s", bool2str(vim.g.autoformat_enabled)))
end

function M.toggle_buffer_autoformat(bufnr)
  bufnr = bufnr or 0
  local old_val = vim.b[bufnr].autoformat_enabled
  if old_val == nil then old_val = vim.g.autoformat_enabled end
  vim.b[bufnr].autoformat_enabled = not old_val
  vim.notify(string.format("Buffer autoformatting %s", bool2str(vim.b[bufnr].autoformat_enabled)))
end

return M
